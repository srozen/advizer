defmodule AdvizerWeb.SimulationController do
  use AdvizerWeb, :controller

  alias Advizer.Quotations
  alias Advizer.Quotations.{Simulation, SimulationNotifier}
  alias Advizer.Accounts.User

  def new(conn, _params) do
    changeset = User.changeset(%User{simulation: %Simulation{}}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Quotations.create_user_and_simulation(user_params) do
      {:ok, %{simulation: simulation} = user} ->
        SimulationNotifier.deliver_simulation_link(
          user,
          Routes.simulation_url(conn, :show, simulation)
        )

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
end
