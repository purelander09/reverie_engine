defmodule ReverieEngineWeb.MessageHistoryController do
  use ReverieEngineWeb, :controller

  alias ReverieEngine.Receiver

  def show(conn, %{"id" => id}) do
    message = Receiver.get_message!(id)
    render(conn, "show.html", message: message)
  end
end
