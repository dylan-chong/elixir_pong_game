defmodule PongGameWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:game", message, socket) do
    {:ok, socket}
  end

  def handle_in("up", _, socket) do
    game_state = GenServer.call({:global, :default_game}, :move_paddle_up)
    {:noreply, socket}
  end

  def handle_in("down", _, socket) do
    game_state = GenServer.call({:global, :default_game}, :move_paddle_down)
    {:noreply, socket}
  end
end
