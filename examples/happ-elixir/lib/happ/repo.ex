defmodule Happ.Repo do
  use Ecto.Repo,
    otp_app: :happ,
    adapter: Ecto.Adapters.Postgres
end
