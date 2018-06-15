defmodule Plan9Web.PageController do
  use Plan9Web, :controller
  alias Plan9.Events

  def index(conn, _params) do
    events = Events.list_future_events()
    render conn, "index.html", events: events
  end
end
