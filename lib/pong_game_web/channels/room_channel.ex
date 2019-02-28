defmodule PongGameWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:game", message, socket) do
    {:ok, socket}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    game_state = GenServer.call({:global, :default_game}, :increment_count)
    broadcast!(socket, "new_msg", game_state)
    {:noreply, socket}
  end

  def handle_in("start_timer", _, socket) do
    PongGameWeb.Endpoint.broadcast("timer:start", "start_timer", %{})
    {:noreply, socket}
  end

  def handle_in("new_time", msg, socket) do
    push socket, "new_time", msg
    {:noreply, socket}
  end
end
