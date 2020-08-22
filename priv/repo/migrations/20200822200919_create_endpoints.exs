defmodule ReverieEngine.Repo.Migrations.CreateEndpoints do
  use Ecto.Migration

  def change do
    create table(:endpoints) do
      add :name, :string
      add :active, :boolean, default: false, null: false
      add :created, :date
      add :updated, :date
      add :description, :text
      add :controlled, :boolean, default: false, null: false
      add :require_authorization, :boolean, default: false, null: false
      add :created_by, :string
      add :message_type, :string
      add :accept_any_message_type, :boolean, default: false, null: false

      timestamps()
    end

  end
end
