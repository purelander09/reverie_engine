defmodule ReverieEngineWeb.EDIController do
    use ReverieEngineWeb, :controller

    alias ReverieEngine.Communication
    alias ReverieEngine.Receiver

    def index(conn, _params) do
        endpoints = Communication.list_endpoints()
        render(conn, "index.html", endpoints: endpoints )
    end

    def show(conn, %{"id" => id}) do
    end

    def receive_message(conn, %{"endpoint" => endpoint}) do
    end

    def show_message_history(conn, %{"endpoint" => endpoint}) do
        messages = Receiver.messages_for_endpoint(endpoint)
        render(conn, "messages.html", messages: messages)
    end
end