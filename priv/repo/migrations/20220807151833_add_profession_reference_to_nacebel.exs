defmodule Advizer.Repo.Migrations.AddProfessionReferenceToNacebel do
  use Ecto.Migration

  def change do
    alter table(:nacebels) do
      add :profession_id, references(:professions, on_delete: :delete_all)
    end
  end
end
