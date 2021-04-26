  defmodule HappWeb.PageController do
  use HappWeb, :controller

  plug :put_layout, "app.html"

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
