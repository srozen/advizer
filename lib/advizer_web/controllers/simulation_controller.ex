defmodule AdvizerWeb.SimulationController do
  use AdvizerWeb, :controller

  alias Advizer.Quotations
  alias Advizer.Quotations.Simulation

  def new(conn, _params) do
    changeset = Quotations.change_simulation(%Simulation{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"simulation" => %{"nacebel_codes" => nacebel_codes} = simulation_params}) do
    simulation_params = %{
      simulation_params
      | "nacebel_codes" => format_nacebel_codes(nacebel_codes)
    }

    case Quotations.create_simulation(simulation_params) do
      {:ok, simulation} ->
        conn
        |> put_flash(:info, "Simulation created successfully.")
        |> redirect(to: Routes.simulation_path(conn, :show, simulation))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => uuid}) do
    simulation = Quotations.get_simulation_by_uuid!(uuid)
    render(conn, "show.html", simulation: simulation)
  end

  defp format_nacebel_codes(""), do: []
  defp format_nacebel_codes(nil), do: []
  defp format_nacebel_codes(codes), do: String.split(codes, ",")
end
