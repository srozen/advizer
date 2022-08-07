defmodule AdvizerWeb.SimulationControllerTest do
  use AdvizerWeb.ConnCase

  @create_attrs %{
    email: "foo@mail.com",
    phone_number: "047434343",
    address: "street 1",
    first_name: "John",
    last_name: "Doe",
    simulation: %{
      annual_revenue: 42,
      enterprise_number: "0123456789",
      legal_name: "some legal_name",
      nacebel_codes: "12345",
      natural_person: true
    }
  }
  @invalid_attrs %{
    email: nil,
    phone_number: "047434343",
    address: "street 1",
    first_name: "John",
    last_name: "Doe",
    simulation: %{
      annual_revenue: 42,
      enterprise_number: "0123456789",
      legal_name: "some legal_name",
      nacebel_codes: nil,
      natural_person: true
    }
  }

  describe "new simulation" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.simulation_path(conn, :new))
      assert html_response(conn, 200) =~ "New Simulation"
    end
  end

  describe "create simulation" do
    import Advizer.QuotationsFixtures

    test "redirects to show when data is valid", %{conn: conn} do
      nacebel_fixture()
      conn = post(conn, Routes.simulation_path(conn, :create), user: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.simulation_path(conn, :show, id)

      conn = get(conn, Routes.simulation_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Simulation"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.simulation_path(conn, :create), user: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Simulation"
    end
  end
end
