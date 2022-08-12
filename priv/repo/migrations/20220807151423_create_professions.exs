defmodule Advizer.Repo.Migrations.CreateProfessions do
  use Ecto.Migration

  def change do
    create table(:professions) do
      add :name, :string
      add :deductible_formula, :string
      add :coverage_ceiling_formula, :string
      add :covers, {:array, :string}

      timestamps()
    end
  end
end
