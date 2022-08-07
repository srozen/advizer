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
end
