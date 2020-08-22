defmodule ReverieEngine.ReceiverTest do
  use ReverieEngine.DataCase

  alias ReverieEngine.Receiver

  describe "messages" do
    alias ReverieEngine.Receiver.Message

    @valid_attrs %{endpoint: "some endpoint", error: true, headers: "some headers", message_body: "some message_body", next_step: "some next_step", received: ~D[2010-04-17], sent: ~D[2010-04-17], source: "some source"}
    @update_attrs %{endpoint: "some updated endpoint", error: false, headers: "some updated headers", message_body: "some updated message_body", next_step: "some updated next_step", received: ~D[2011-05-18], sent: ~D[2011-05-18], source: "some updated source"}
    @invalid_attrs %{endpoint: nil, error: nil, headers: nil, message_body: nil, next_step: nil, received: nil, sent: nil, source: nil}

    def message_fixture(attrs \\ %{}) do
      {:ok, message} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Receiver.create_message()

      message
    end

    test "list_messages/0 returns all messages" do
      message = message_fixture()
      assert Receiver.list_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Receiver.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      assert {:ok, %Message{} = message} = Receiver.create_message(@valid_attrs)
      assert message.endpoint == "some endpoint"
      assert message.error == true
      assert message.headers == "some headers"
      assert message.message_body == "some message_body"
      assert message.next_step == "some next_step"
      assert message.received == ~D[2010-04-17]
      assert message.sent == ~D[2010-04-17]
      assert message.source == "some source"
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Receiver.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      assert {:ok, %Message{} = message} = Receiver.update_message(message, @update_attrs)
      assert message.endpoint == "some updated endpoint"
      assert message.error == false
      assert message.headers == "some updated headers"
      assert message.message_body == "some updated message_body"
      assert message.next_step == "some updated next_step"
      assert message.received == ~D[2011-05-18]
      assert message.sent == ~D[2011-05-18]
      assert message.source == "some updated source"
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = Receiver.update_message(message, @invalid_attrs)
      assert message == Receiver.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Receiver.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Receiver.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Receiver.change_message(message)
    end
  end
end
