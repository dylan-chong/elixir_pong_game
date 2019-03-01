defmodule PongGameWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:game", message, socket) do
    {:ok, socket}
  end

  def handle_in("key_event", %{"key" => key, "direction" => direction}, socket) do
    GenServer.call({:global, :default_game}, {
      :move_paddle,
      case key do
        "up" -> :up
        "down" -> :down
      end,
      case direction do
        "press" -> true
        "release" -> false
      end
    })
    {:noreply, socket}
  end
end
