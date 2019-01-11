# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :pong_game,
  ecto_repos: [PongGame.Repo]

# Configures the endpoint
config :pong_game, PongGameWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "CbVrAKSdfadeiVDoLcv6JtG/Je5vhvJHiYgb9nmQ0Vk1EoRMsrEBAZxIsn7ym3g+",
  render_errors: [view: PongGameWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PongGame.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
