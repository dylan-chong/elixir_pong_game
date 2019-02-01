defmodule PongGame.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      PongGame.Repo,
      # Start the endpoint when the application starts
      PongGameWeb.Endpoint
      # Starts a worker by calling: PongGame.Worker.start_link(arg)
      # {PongGame.Worker, arg},
#                  {PongGameWeb.Game, []}
    ]
    # start genserver ? ???
    PongGameWeb.Game.start_link

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PongGame.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PongGameWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
