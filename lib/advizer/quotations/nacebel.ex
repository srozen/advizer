defmodule Advizer.Quotations.Nacebel do
  use Ecto.Schema
  import Ecto.Changeset

  schema "nacebels" do
    field :code, :string
    field :label_de, :string
    field :label_en, :string
    field :label_fr, :string
    field :label_nl, :string
    field :level_number, :string
    field :parent_code, :string
    belongs_to :profession, Advizer.Quotations.Profession

    timestamps()
  end

  @doc false
  def changeset(nacebel_code, attrs) do
    nacebel_code
    |> cast(attrs, [
      :level_number,
      :code,
      :parent_code,
      :label_nl,
      :label_fr,
      :label_de,
      :label_en,
      :profession_id
    ])
  end
end
