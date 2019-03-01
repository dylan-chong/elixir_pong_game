defmodule PongGameWeb.Game do
  use GenServer

  @paddle_speed 3

  def start_link() do
    GenServer.start_link(__MODULE__, nil, name: {:global, :default_game})
  end

  @impl true
  def init(_) do
    schedule()
    {:ok, %{position: %{x: 20, y: 20}, keys: %{down: false, up: false}}}
  end

  @impl true
  def handle_call({:move_paddle, key, direction}, _from, state) do
    new_state = put_in(state.keys[key], direction)

    {:reply, new_state, new_state}
  end

  @impl true
  def handle_info(:refresh_clients, state) do
    new_state = put_in(state.position.y, state.position.y + calculate_y_diff(state.keys))

    PongGameWeb.Endpoint.broadcast!("room:game", "new_game_state", new_state)
    schedule()
    {:noreply, new_state}
  end

  defp calculate_y_diff(%{down: boolean, up: boolean}), do: 0
  defp calculate_y_diff(%{down: true, up: false}), do: @paddle_speed
  defp calculate_y_diff(%{down: false, up: true}), do: -@paddle_speed

  defp schedule do
    Process.send_after(self(), :refresh_clients, 30)
  end
end
