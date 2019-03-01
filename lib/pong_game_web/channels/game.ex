defmodule PongGameWeb.Game do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, nil, name: {:global, :default_game})
  end

  @impl true
  def init(_) do
    schedule()
    {:ok, %{position: %{x: 20, y: 20}}}
  end

  @impl true
  def handle_call(:move_paddle_up, _from, state) do
    new_state = %{state | position: %{x: state.position.x, y: state.position.y - 3}}
    {:reply, new_state, new_state}
  end

  @impl true
  def handle_call(:move_paddle_down, _from, state) do
    new_state = %{state | position: %{x: state.position.x, y: state.position.y + 3}}
    {:reply, new_state, new_state}
  end

  @impl true
  def handle_info(:refresh_clients, state) do
    PongGameWeb.Endpoint.broadcast!("room:game", "new_game_state", state)
    schedule()
    {:noreply, state}
  end

  defp schedule do
    Process.send_after(self(), :refresh_clients, 30)
  end
end
