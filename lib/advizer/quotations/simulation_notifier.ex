defmodule Advizer.Quotations.SimulationNotifier do
  @moduledoc """
  This notifier delivers saved simulations to the user.
  """
  import Swoosh.Email

  alias Advizer.Mailer

  # Delivers the email using the application mailer.
  defp deliver(recipient, subject, body) do
    email =
      new()
      |> to(recipient)
      |> from({"AdviZer", "contact@advizer.io"})
      |> subject(subject)
      |> text_body(body)

    with {:ok, _metadata} <- Mailer.deliver(email) do
      {:ok, email}
    end
  end

  @doc """
  Deliver instructions to access the simulation.
  """
  def deliver_simulation_link(user, url) do
    deliver(user.email, "Your simulation has been saved", """
    Hi #{user.first_name} #{user.last_name},
    You can retrieve the simulation you performed with our service
    at any time by accessing this url #{url}.
    """)
  end
end
