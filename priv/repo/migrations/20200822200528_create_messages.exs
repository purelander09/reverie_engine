defmodule ReverieEngine.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :message_body, :text
      add :endpoint, :string
      add :source, :string
      add :headers, :text
      add :next_step, :string
      add :error, :boolean, default: false, null: false
      add :sent, :date
      add :received, :date

      timestamps()
    end

  end
end
