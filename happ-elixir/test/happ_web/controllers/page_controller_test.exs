defmodule HappWeb.PageControllerTest do
  use HappWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "LiveDashboard"
  end
end
