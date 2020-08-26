require IEx

defmodule ReverieEngineWeb.EDIController do
    use ReverieEngineWeb, :controller

    alias ReverieEngine.Communication
    alias ReverieEngine.Receiver

    def index(conn, _params) do
        endpoints = Communication.list_endpoints()
        render(conn, "index.html", endpoints: endpoints )
    end

    def show(conn, %{"id" => id}) do
        endpoint = Communication.get_endpoint!(id)
        render(conn, "show.html", endpoint: endpoint)
    end

    def receive_message(conn, %{"endpoint" => endpoint}) do
        comm_point = Communication.get_endpoint_by_name(endpoint)

        {:ok, body, conn}= Plug.Conn.read_body(conn)
        IEx.pry()
        case comm_point do
            nil -> conn |> render(:"404")
            comm_point -> add_message(body, comm_point)
        end
        conn
    end

    def show_message_history(conn, %{"endpoint" => endpoint}) do
        messages = Receiver.messages_for_endpoint(endpoint)
        render(conn, "messages.html", messages: messages)
    end

    defp add_message(message, endpoint) do
        msg = %{
            endpoint: endpoint.name,
            message_body: message,
            next_step: "parse",
            error: false,
            headers: "x-application/hl7v2-er7",
            received: Date.utc_today(),
            sent: Date.utc_today(),
            source: "POST"
        }

        Receiver.create_message(msg)
    end
end
