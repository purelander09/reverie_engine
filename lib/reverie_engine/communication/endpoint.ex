defmodule ReverieEngine.Communication.Endpoint do
  use Ecto.Schema
  import Ecto.Changeset

  schema "endpoints" do
    field :accept_any_message_type, :boolean, default: false
    field :active, :boolean, default: false
    field :controlled, :boolean, default: false
    field :created, :date
    field :created_by, :string
    field :description, :string
    field :message_type, :string
    field :name, :string
    field :require_authorization, :boolean, default: false
    field :updated, :date

    timestamps()
  end

  @doc false
  def changeset(endpoint, attrs) do
    endpoint
    |> cast(attrs, [:name, :active, :created, :updated, :description, :controlled, :require_authorization, :created_by, :message_type, :accept_any_message_type])
    |> validate_required([:name, :active, :created, :updated, :description, :controlled, :require_authorization, :created_by, :message_type, :accept_any_message_type])
  end
end
