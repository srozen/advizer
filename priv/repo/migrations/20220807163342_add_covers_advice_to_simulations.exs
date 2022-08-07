defmodule Advizer.Repo.Migrations.AddCoversAdviceToSimulations do
  use Ecto.Migration

  def change do
    alter table(:simulations) do
      add :covers_advice, {:array, :string}
    end
  end
end
