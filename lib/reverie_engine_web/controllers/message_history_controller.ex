require IEx

defmodule ReverieEngineWeb.MessageHistoryController do
  use ReverieEngineWeb, :controller

  alias ReverieEngine.Receiver
  alias ReverieMessageToolkit.HL7GenericParser

  def show(conn, %{"id" => id}) do
    message = Receiver.get_message!(id)
    parsed_message = HL7GenericParser.parse(message.message_body)
    IEx.pry()
    render(conn, "show.html", message: message, parsed_message: parsed_message)
  end
end
