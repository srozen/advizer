defmodule Advizer.Accounts.User do
  @moduledoc """
  User schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Advizer.Quotations.Simulation

  schema "users" do
    field :email, :string
    field :phone_number, :string
    field :address, :string
    field :first_name, :string
    field :last_name, :string

    has_one :simulation, Simulation

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :phone_number, :address, :first_name, :last_name])
    |> cast_assoc(:simulation, required: true, with: &Simulation.changeset/2)
    |> validate_required([:phone_number, :address, :first_name, :last_name])
    |> validate_email()
  end

  def create_changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :phone_number, :address, :first_name, :last_name])
    |> cast_assoc(:simulation,
      required: true,
      with: &Advizer.Quotations.setup_simulation_changeset/2
    )
    |> validate_required([:phone_number, :address, :first_name, :last_name])
    |> validate_email()
  end

  defp validate_email(changeset) do
    changeset
    |> validate_required([:email])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:email, max: 160)
  end
end
