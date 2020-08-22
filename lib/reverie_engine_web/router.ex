defmodule ReverieEngineWeb.Router do
  use ReverieEngineWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :endpoint do
  end

  scope "/", ReverieEngineWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/endpoint", ReverieEngineWeb do
    pipe_through :endpoint

    get "/", EndpointController, :index
    get "/:endpoint", EndpointController, :show_message_history

    post "/:endpoint", EndpointController, :receive_message
  end

  # Other scopes may use custom stacks.
  # scope "/api", ReverieEngineWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: ReverieEngineWeb.Telemetry
    end
  end
end
