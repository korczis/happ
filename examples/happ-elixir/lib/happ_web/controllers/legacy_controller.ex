defmodule HappWeb.LegacyController do
  use HappWeb, :controller

  plug :put_layout, "legacy.html"

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
