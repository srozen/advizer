defmodule Advizer.Repo.Migrations.AddUserReferenceToSimulation do
  use Ecto.Migration

  def change do
    alter table(:simulations) do
      add :user_id, references(:users, on_delete: :delete_all)
    end
  end
end
