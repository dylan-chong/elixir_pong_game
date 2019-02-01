defmodule PongGameWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:game", message, socket) do
    {:ok, socket}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast!(socket, "new_msg", %{body: body})
    pid = GenServer.whereis({:global, :default_game})
    GenServer.call(pid, :test)
    {:noreply, socket}
  end
end
