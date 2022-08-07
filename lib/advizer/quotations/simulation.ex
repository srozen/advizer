defmodule Advizer.Quotations.Simulation do
  use Ecto.Schema
  import Ecto.Changeset

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
      :nacebel_codes,
      :deductible_formula,
      :coverage_ceiling_formula
    ])
    |> validate_required([
      :annual_revenue,
      :enterprise_number,
      :legal_name,
      :natural_person,
      :nacebel_codes
    ])
  end
end
