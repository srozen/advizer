defmodule Advizer.Repo do
  use Ecto.Repo,
    otp_app: :advizer,
    adapter: Ecto.Adapters.Postgres
end
