defmodule PongGameWeb.Game do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, nil, name: {:global, :default_game})
  end

  def init(_) do
    {:ok, "hello world"}
  end

  @impl true
  def handle_call(:test, _from, state) do
    IO.puts state
    {:reply, nil, state}
  end
end
