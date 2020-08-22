defmodule ReverieEngineWeb.EndpointController do
    use ReverieEngineWeb, :controller

    def index(conn, _params) do
        render(conn, "index.html")
    end

    def show(conn, %{"id" => id}) do
    end

    def receive_message(conn, %{"endpoint" => endpoint}) do
    end

    def show_message_history(conn, %{"endpoint" => endpoint}) do
    end
end