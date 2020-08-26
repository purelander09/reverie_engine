defmodule ReverieEngineWeb.Parsers.RawBody do
  @behaviour Plug.Parsers

  def init(opts) do
    {body_reader, opts} = Keyword.pop(opts, :body_reader, {Plug.Conn, :read_body, []})
    {body_reader, opts}
  end

  def parse(conn, "x-application", "hl7-v2+er7", _params, _opts) do
    {:ok, body, conn} = Plug.Conn.read_body(conn)
    body = [body | conn.private[:raw_body] || []]
    body_params = Map.new()
    body_params = Map.put(body_params, :text, body)
    {:ok, body_params, conn}
  end

  def parse(conn, _type, _subtype, _headers, _opts) do
    {:next, conn}
  end
end
