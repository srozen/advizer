defmodule AdvizerWeb.PageController do
  use AdvizerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
