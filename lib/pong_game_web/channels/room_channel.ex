defmodule PongGameWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:game", message, socket) do
    {:ok, socket}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    pid = GenServer.whereis({:global, :default_game})
    game_state = GenServer.call(pid, :increment_count)
    broadcast!(socket, "new_msg", game_state)
    {:noreply, socket}
  end
end
