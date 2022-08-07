defmodule AdvizerWeb.SimulationControllerTest do
  use AdvizerWeb.ConnCase

  @create_attrs %{
    annual_revenue: 42,
    enterprise_number: "some enterprise_number",
    legal_name: "some legal_name",
    nacebel_codes: [],
    natural_person: true
  }
  @invalid_attrs %{
    annual_revenue: nil,
    coverage_ceiling_formula: nil,
    deductible_formula: nil,
    enterprise_number: nil,
    legal_name: nil,
    nacebel_codes: nil,
    natural_person: nil
  }

  describe "new simulation" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.simulation_path(conn, :new))
      assert html_response(conn, 200) =~ "New Simulation"
    end
  end

  describe "create simulation" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.simulation_path(conn, :create), simulation: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.simulation_path(conn, :show, id)

      conn = get(conn, Routes.simulation_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Simulation"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.simulation_path(conn, :create), simulation: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Simulation"
    end
  end
end
