defmodule Advizer.Quotations do
  @moduledoc """
  Quotations context.
  """

  import Ecto.Query, warn: false
  alias Advizer.Repo

  alias Advizer.Quotations.Nacebel

  @doc """
  Creates a Nacebel information.

    ## Examples
      iex> create_nacebel(%{field: value})
      {:ok, %Nacebel{}}

      iex> create_nacebel(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  @spec create_nacebel(none() | %{}) :: {:error, %Ecto.Changeset{}} | {:ok, %Nacebel{}}
  def create_nacebel(attrs \\ %{}) do
    %Nacebel{}
    |> Nacebel.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Upserts a Nacebel information.
  The upsert strategy doesn't update in case of conflict, as it is only used for
  seeding and the set of data is expected to evolve very slowly.

    ## Examples
      iex> upsert_nacebel(%{field: value})
      {:ok, %Nacebel{}}

      iex> upsert_nacebel(%{unique_field: duplicated})
      {:ok, %Nacebel{}}

      iex> upsert_nacebel(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  @spec upsert_nacebel(none() | %{}) :: {:error, %Ecto.Changeset{}} | {:ok, %Nacebel{}}
  def upsert_nacebel(attrs \\ %{}) do
    %Nacebel{}
    |> Nacebel.changeset(attrs)
    |> Repo.insert(on_conflict: :nothing)
  end

  @doc """
  Check that a list of nacebel codes exists in database.

    ## Examples
      iex> valid_nacebel_codes(["valid"])
      {:ok, []}

      iex> valid_nacebel_codes(["invalid"])
      {:error, []]}
  """
  @spec valid_nacebel_codes(list) :: {:error, [binary()]} | {:ok, []}
  def valid_nacebel_codes(codes) do
    results =
      Nacebel
      |> where([n], n.code in ^codes)
      |> select([n], n.code)
      |> Repo.all()

    invalid_codes = codes -- results

    case invalid_codes do
      [] -> {:ok, []}
      _ -> {:error, invalid_codes}
    end
  end
end
