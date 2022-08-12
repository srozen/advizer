defmodule Advizer.Quotations.Profession do
  use Ecto.Schema
  import Ecto.Changeset

  schema "professions" do
    field :name, :string
    field :coverage_ceiling_formula, Ecto.Enum, values: [:small, :large]

    field :covers, {:array, Ecto.Enum},
      values: [
        :after_delivery,
        :public_liability,
        :professional_indemnity,
        :entrusted_objects,
        :legal_expenses
      ]

    field :deductible_formula, Ecto.Enum, values: [:small, :medium, :large]

    timestamps()
  end

  @doc false
  def changeset(profession, attrs) do
    profession
    |> cast(attrs, [:name, :deductible_formula, :coverage_ceiling_formula, :covers])
    |> validate_required([:name, :deductible_formula, :coverage_ceiling_formula, :covers])
  end
end
