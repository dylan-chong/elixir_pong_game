defmodule PongGameWeb.PageController do
  use PongGameWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
