use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :pong_game, PongGameWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :pong_game, PongGame.Repo,
  username: "postgres",
  password: "postgres",
  database: "pong_game_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
