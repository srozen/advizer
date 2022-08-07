defmodule AdvizerWeb.SimulationController do
  use AdvizerWeb, :controller

  alias Advizer.Quotations
  alias Advizer.Quotations.Simulation

  def new(conn, _params) do
    changeset = Quotations.change_simulation(%Simulation{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"simulation" => simulation_params}) do
    case Quotations.create_simulation(simulation_params) do
      {:ok, simulation} ->
        conn
        |> put_flash(:info, "Simulation created successfully.")
        |> redirect(to: Routes.simulation_path(conn, :show, simulation))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    simulation = Quotations.get_simulation!(id)
    render(conn, "show.html", simulation: simulation)
  end
end