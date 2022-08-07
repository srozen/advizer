defmodule Advizer.Quotations do
  @moduledoc """
  Quotations context.
  """

  import Ecto.Query, warn: false
  alias Advizer.Repo

  alias Advizer.Quotations.{Nacebel, Profession, Simulation}

  @nacebel_code_level "5"

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
      |> where([n], n.level_number == @nacebel_code_level)
      |> select([n], n.code)
      |> Repo.all()

    invalid_codes = codes -- results

    case invalid_codes do
      [] -> {:ok, []}
      _ -> {:error, invalid_codes}
    end
  end

  @doc """
  Gets a single simulation.

  Raises `Ecto.NoResultsError` if the Simulation does not exist.

  ## Examples

      iex> get_simulation!(123)
      %Simulation{}

      iex> get_simulation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_simulation_by_uuid!(uuid), do: Repo.get_by!(Simulation, uuid: uuid)

  @doc """
  Creates a simulation.

  ## Examples

      iex> create_simulation(%{field: value})
      {:ok, %Simulation{}}

      iex> create_simulation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_simulation(attrs \\ %{}) do
    %Simulation{}
    |> Simulation.changeset(attrs)
    |> Ecto.Changeset.put_change(:uuid, UUID.uuid4(:hex))
    |> make_advice()
    |> Repo.insert()
  end

  defp make_advice(%Ecto.Changeset{valid?: false} = changeset), do: changeset

  defp make_advice(%Ecto.Changeset{changes: %{nacebel_codes: codes}} = changeset) do
    Nacebel
    |> where([n], n.code in ^codes)
    |> join(:inner, [n], p in assoc(n, :profession))
    |> select([n, p], %{
      deductible_formula: p.deductible_formula,
      covers: p.covers,
      coverage_ceiling_formula: p.coverage_ceiling_formula
    })
    |> Repo.all()
    |> Enum.reduce(
      %{covers: MapSet.new(), deductible_formula: :small, coverage_ceiling_formula: :small},
      &aggregate_advice/2
    )
    |> apply_advice(changeset)
  end

  defp apply_advice(
         %{
           covers: covers,
           deductible_formula: deductible_formula,
           coverage_ceiling_formula: coverage_formula
         },
         changeset
       ) do
    changeset
    |> Ecto.Changeset.put_change(:covers_advice, MapSet.to_list(covers))
    |> Ecto.Changeset.put_change(:deductible_formula, deductible_formula)
    |> Ecto.Changeset.put_change(:coverage_ceiling_formula, coverage_formula)
  end

  # Rationale chosen here is to get the most covered possible regarding the given set of Nacebel and associated profession advice.
  defp aggregate_advice(
         %{
           covers: covers,
           deductible_formula: deductible_formula,
           coverage_ceiling_formula: coverage_formula
         },
         %{
           covers: acc_covers,
           deductible_formula: acc_deductible_formula,
           coverage_ceiling_formula: acc_coverage_formula
         }
       ) do
    %{
      covers: MapSet.union(acc_covers, MapSet.new(covers)),
      deductible_formula: highest_formula(deductible_formula, acc_deductible_formula),
      coverage_ceiling_formula: highest_formula(coverage_formula, acc_coverage_formula)
    }
  end

  defp highest_formula(:small, actual), do: actual
  defp highest_formula(:large, _actual), do: :large
  defp highest_formula(candidate, :small), do: candidate
  defp highest_formula(_candidate, :large), do: :large
  defp highest_formula(candidate, _), do: candidate

  # end
  @doc """
  Returns an `%Ecto.Changeset{}` for tracking simulation changes.

  ## Examples

      iex> change_simulation(simulation)
      %Ecto.Changeset{data: %Simulation{}}

  """
  def change_simulation(%Simulation{} = simulation, attrs \\ %{}) do
    Simulation.changeset(simulation, attrs)
  end

  @doc """
  Creates a profession.

  ## Examples

      iex> create_profession(%{field: value})
      {:ok, %Profession{}}

      iex> create_profession(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_profession(attrs \\ %{}) do
    %Profession{}
    |> Profession.changeset(attrs)
    |> Repo.insert()
  end
end
