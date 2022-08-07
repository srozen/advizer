defmodule Advizer.Quotations.Simulation do
  use Ecto.Schema
  import Ecto.Changeset

  alias Advizer.Quotations

  schema "simulations" do
    field :annual_revenue, :integer
    field :enterprise_number, :string
    field :legal_name, :string
    field :natural_person, :boolean, default: false
    field :nacebel_codes, {:array, :string}
    field :deductible_formula, Ecto.Enum, values: [:small, :medium, :large], default: :medium
    field :coverage_ceiling_formula, Ecto.Enum, values: [:small, :large], default: :large

    timestamps()
  end

  @doc false
  def changeset(simulation, attrs) do
    simulation
    |> cast(attrs, [
      :annual_revenue,
      :enterprise_number,
      :legal_name,
      :natural_person,
      :nacebel_codes
    ])
    |> validate_required([
      :annual_revenue,
      :enterprise_number,
      :legal_name,
      :natural_person
    ])
    |> validate_change(:nacebel_codes, &nonempty_nacebel_codes/2)
    |> validate_change(:nacebel_codes, &existing_nacebel_codes/2)
  end

  def nonempty_nacebel_codes(:nacebel_codes, nacebel_codes) do
    case nacebel_codes do
      [] -> [nacebel_codes: "must have at least one nacebel code"]
      _ -> []
    end
  end

  def existing_nacebel_codes(:nacebel_codes, nacebel_codes) do
    Quotations.valid_nacebel_codes(nacebel_codes)
    |> case do
      {:ok, []} -> []
      {:error, codes} -> [nacebel_codes: "#{codes} are not valid level 5 nacebel codes"]
    end
  end
end
