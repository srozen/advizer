defmodule AdvizerWeb.PageControllerTest do
  use AdvizerWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "New Simulation"
  end
end
