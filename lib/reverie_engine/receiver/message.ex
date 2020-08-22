defmodule ReverieEngine.Receiver.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :endpoint, :string
    field :error, :boolean, default: false
    field :headers, :string
    field :message_body, :string
    field :next_step, :string
    field :received, :date
    field :sent, :date
    field :source, :string

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:message_body, :endpoint, :source, :headers, :next_step, :error, :sent, :received])
    |> validate_required([:message_body, :endpoint, :source, :headers, :next_step, :error, :sent, :received])
  end
end
