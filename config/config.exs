# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :happ,
  ecto_repos: [Happ.Repo]

# Configures the endpoint
config :happ, HappWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "poGBa+wu1Cea7inDeebz4i4+dpOx3YmnF5BeQOpQnUVBNTrzZxwQM2qA2m5ZZagM",
  render_errors: [view: HappWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Happ.PubSub,
  live_view: [signing_salt: "l5ddAgRI"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
