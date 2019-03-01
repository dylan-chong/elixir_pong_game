defmodule PongGameWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:game", message, socket) do
    id = :os.system_time
    GenServer.call({:global, :default_game}, {:set_player, id})
    {:ok, %Phoenix.Socket{socket | assigns: %{id: id}}}
  end

  def handle_in("key_event", %{"key" => key, "direction" => direction}, socket) do
    GenServer.call({:global, :default_game}, {
      :update_paddle,
      socket.assigns.id,
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
