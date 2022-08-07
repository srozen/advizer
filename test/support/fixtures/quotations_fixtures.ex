defmodule Advizer.QuotationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Advizer.Quotations` context.
  """

  @doc """
  Generate a nacebel.
  """
  def nacebel_fixture(attrs \\ %{}) do
    {:ok, nacebel} =
      attrs
      |> Enum.into(%{
        code: "12345"
      })
      |> Advizer.Quotations.create_nacebel()

    nacebel
  end

  @doc """
  Generate a simulation.
  """
  def simulation_fixture(attrs \\ %{}) do
    {:ok, simulation} =
      attrs
      |> Enum.into(%{
        annual_revenue: 42,
        enterprise_number: "some enterprise_number",
        legal_name: "some legal_name",
        nacebel_codes: [],
        natural_person: true
      })
      |> Advizer.Quotations.create_simulation()

    simulation
  end
end
