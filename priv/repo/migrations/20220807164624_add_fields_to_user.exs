defmodule Advizer.Repo.Migrations.AddFieldsToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :phone_number, :string
      add :address, :string
      add :first_name, :string
      add :last_name, :string
    end
  end
end
