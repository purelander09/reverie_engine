defmodule ReverieEngine.Repo do
  use Ecto.Repo,
    otp_app: :reverie_engine,
    adapter: Ecto.Adapters.Postgres
end
