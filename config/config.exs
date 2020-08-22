# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :reverie_engine,
  ecto_repos: [ReverieEngine.Repo]

# Configures the endpoint
config :reverie_engine, ReverieEngineWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "k35ETCobvucW6FCMShImlZAMCPcyZ0H3T0DJN/kBXbZKwshxXuYN14W/7TjIP65V",
  render_errors: [view: ReverieEngineWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ReverieEngine.PubSub,
  live_view: [signing_salt: "L4G5l09E"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
