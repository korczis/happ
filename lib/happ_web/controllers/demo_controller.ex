defmodule HappWeb.DemoController do
  use HappWeb, :controller

  plug :put_layout, "demo.html"

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
