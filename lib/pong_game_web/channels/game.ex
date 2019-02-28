defmodule PongGameWeb.Game do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, nil, name: {:global, :default_game})
  end

  @impl true
  def init(_) do
    {:ok, %{count: 0}}
  end

  @impl true
  def handle_call(:increment_count, _from, state) do
    new_state = %{state | count: state.count + 1}
    IO.inspect(new_state)
    {:reply, new_state, new_state}
  end
end
