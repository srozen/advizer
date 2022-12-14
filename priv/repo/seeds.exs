# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Advizer.Repo.insert!(%Advizer.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

require Logger
alias Advizer.{Quotations}

# Seeds Profession Advise-base
{:ok, %{id: profession_id}} =
  %{
    name: "doctor",
    coverage_ceiling_formula: :large,
    deductible_formula: :small,
    covers: [:legal_expenses]
  }
  |> Quotations.create_profession()

# Seeds Nacebel Information
"nacebel_2008.csv"
|> Path.expand(__DIR__)
|> File.stream!([{:encoding, :latin1}])
|> CSV.decode(
  separator: ?;,
  preprocessor: :none,
  headers: [:level_number, :code, :parent_code, :label_nl, :label_fr, :label_de, :label_en]
)
|> Stream.drop(1)
|> Enum.each(fn line ->
  case line do
    # this is an intermediate header in Nacebel CSV
    {:ok, %{code: "", parent_code: ""} = _entry} ->
      :ok

    {:ok, entry} ->
      Map.put(entry, :profession_id, profession_id)
      |> Quotations.upsert_nacebel()

    {:error, error} ->
      Logger.error(error)
  end
end)
