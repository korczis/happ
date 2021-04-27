defmodule HappWeb.SpaController do
  use HappWeb, :controller

  plug :put_layout, "spa.html"

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
