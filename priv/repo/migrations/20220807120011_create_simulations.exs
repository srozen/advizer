defmodule Advizer.Repo.Migrations.CreateSimulations do
  use Ecto.Migration

  def change do
    create table(:simulations) do
      add :annual_revenue, :integer
      add :enterprise_number, :string
      add :legal_name, :string
      add :natural_person, :boolean, default: false, null: false
      add :nacebel_codes, {:array, :string}
      add :deductible_formula, :string
      add :coverage_ceiling_formula, :string

      timestamps()
    end
  end
end
