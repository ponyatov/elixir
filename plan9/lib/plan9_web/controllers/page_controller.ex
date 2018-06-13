defmodule Plan9Web.PageController do
  use Plan9Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
