defmodule PongGame.Repo do
  use Ecto.Repo,
    otp_app: :pong_game,
    adapter: Ecto.Adapters.Postgres
end
