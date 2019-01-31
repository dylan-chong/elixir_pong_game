defmodule PongGameWeb.RoomChannel do
  use Phoenix.Channel

  # TODO rename lobby
  def join("room:lobby", message, socket) do
    IO.inspect [message, socket]
    {:ok, socket}
  end
  def join("room:" <> _private_room_id, _params, _socket) do
    # TODO remove this?
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast!(socket, "new_msg", %{body: body})
    {:noreply, socket}
  end
end
