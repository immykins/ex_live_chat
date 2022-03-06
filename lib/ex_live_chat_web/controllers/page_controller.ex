defmodule ExLiveChatWeb.PageController do
  use ExLiveChatWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
