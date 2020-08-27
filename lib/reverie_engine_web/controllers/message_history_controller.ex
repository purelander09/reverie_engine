require IEx

defmodule ReverieEngineWeb.MessageHistoryController do
  use ReverieEngineWeb, :controller

  alias ReverieEngine.Receiver
  alias ReverieMessageToolkit.HL7GenericParser

  @spec show(Plug.Conn.t(), map) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    message = Receiver.get_message!(id)
    parsed_message = HL7GenericParser.parse(message.message_body)

    msh = Map.get(parsed_message, :MSH)
    version = Map.get(parsed_message, :version)
    field_separator = Map.get(parsed_message, :field_separator)
    repeat_separator = Map.get(parsed_message, :repeat_separator)

    IEx.pry()
    render(
      conn,
      "show.html",
      message: message,
      msh: msh,
      version: version,
      field_separator: field_separator,
      repeat_separator: repeat_separator
    )
  end
end
