defmodule PongGameWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:game", message, socket) do
    {:ok, socket}
  end

  def handle_in("new_msg", _, socket) do
    game_state = GenServer.call({:global, :default_game}, :increment_count)
    broadcast!(socket, "new_msg", game_state)
    {:noreply, socket}
  end
end
