defmodule AdvizerWeb.SimulationView do
  use AdvizerWeb, :view

  def classify_premiums(selected_premiums, quotation) do
    IO.inspect(selected_premiums)
    IO.inspect(quotation)
    :ok
  end
end
