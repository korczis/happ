defmodule HappWeb.PageController do
  use HappWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
