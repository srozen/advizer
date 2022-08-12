defmodule Advizer.Repo.Migrations.CreateNacebelCodes do
  use Ecto.Migration

  def change do
    create table(:nacebels) do
      add :level_number, :string
      add :code, :string
      add :parent_code, :string
      add :label_nl, :string
      add :label_fr, :string
      add :label_de, :string
      add :label_en, :string

      timestamps()
    end

    create unique_index(:nacebels, [:code])
  end
end
