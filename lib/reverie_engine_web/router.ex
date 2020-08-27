defmodule ReverieEngineWeb.Router do
  use ReverieEngineWeb, :router
  use Pow.Phoenix.Router

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

  pipeline :edi do
    plug :accepts, ["*"]
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/", ReverieEngineWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/edi", ReverieEngineWeb do
    pipe_through :browser

    get "/", EDIController, :index
    get "/details/:id", EDIController, :show
    get "/:endpoint", EDIController, :show_message_history
  end

  scope "/message", ReverieEngineWeb do
    pipe_through :browser

    get "/:id", MessageHistoryController, :show
  end

  scope "/edi/receive", ReverieEngineWeb do
    pipe_through :edi
    post "/:endpoint", EDIController, :receive_message
  end

  use Kaffy.Routes, scope: "/admin", pipe_through: [:protected]

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
      pipe_through [:browser, :protected]
      live_dashboard "/dashboard", metrics: ReverieEngineWeb.Telemetry
    end
  end
end
