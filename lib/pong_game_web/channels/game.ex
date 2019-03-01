defmodule PongGameWeb.Game do
  use GenServer

  @paddle_speed 3

  def start_link() do
    GenServer.start_link(__MODULE__, nil, name: {:global, :default_game})
  end

  @impl true
  def init(_) do
    schedule()
    {
      :ok,
      %{
        player_1: %{
          socket_id: :player_not_assigned,
          position: %{
            x: 20,
            y: 20
          },
          keys: %{
            down: false,
            up: false
          }
        },
        player_2: %{
          socket_id: :player_not_assigned,
          position: %{
            x: 1060,
            y: 20
          },
          keys: %{
            down: false,
            up: false
          }
        }
      }
    }
  end

  @impl true
  def handle_call({:set_player, socket_id}, _from, state) do
    IO.inspect(state)
    new_state = cond do
      state.player_1.socket_id == :player_not_assigned ->
        put_in(state.player_1.socket_id, socket_id)
      state.player_2.socket_id == :player_not_assigned ->
        put_in(state.player_2.socket_id, socket_id)
    end

    {:reply, nil, new_state}
  end

  @impl true
  def handle_call({:update_paddle, socket_id, key, direction}, _from, state) do
    new_state = put_in(state[lookup_player(socket_id, state)].keys[key], direction)

    {:reply, new_state, new_state}
  end

  @impl true
  def handle_info(:refresh_clients, state) do
    new_state = put_in(state[:player_1].position.y, state[:player_1].position.y + calculate_y_diff(state[:player_1].keys))
    new_state = put_in(new_state[:player_2].position.y, new_state[:player_2].position.y + calculate_y_diff(new_state[:player_2].keys))

    PongGameWeb.Endpoint.broadcast!("room:game", "new_game_state", new_state)
    schedule()
    {:noreply, new_state}
  end

  defp lookup_player(socket_id, state) do
    new_state = cond do
      state.player_1.socket_id == socket_id ->
        :player_1
      state.player_2.socket_id == socket_id ->
        :player_2
    end
  end
  defp calculate_y_diff(%{down: boolean, up: boolean}), do: 0
  defp calculate_y_diff(%{down: true, up: false}), do: @paddle_speed
  defp calculate_y_diff(%{down: false, up: true}), do: -@paddle_speed

  defp schedule do
    Process.send_after(self(), :refresh_clients, 30)
  end
end
