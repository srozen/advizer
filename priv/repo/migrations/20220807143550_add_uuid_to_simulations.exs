defmodule Advizer.Repo.Migrations.AddUuidToSimulations do
  use Ecto.Migration

  def change do
    alter table(:simulations) do
      add :uuid, :binary
    end

    create unique_index(:simulations, [:uuid])
  end
end
