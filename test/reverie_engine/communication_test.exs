defmodule ReverieEngine.CommunicationTest do
  use ReverieEngine.DataCase

  alias ReverieEngine.Communication

  describe "endpoints" do
    alias ReverieEngine.Communication.Endpoint

    @valid_attrs %{accept_any_message_type: true, active: true, controlled: true, created: ~D[2010-04-17], created_by: "some created_by", description: "some description", message_type: "some message_type", name: "some name", require_authorization: true, updated: ~D[2010-04-17]}
    @update_attrs %{accept_any_message_type: false, active: false, controlled: false, created: ~D[2011-05-18], created_by: "some updated created_by", description: "some updated description", message_type: "some updated message_type", name: "some updated name", require_authorization: false, updated: ~D[2011-05-18]}
    @invalid_attrs %{accept_any_message_type: nil, active: nil, controlled: nil, created: nil, created_by: nil, description: nil, message_type: nil, name: nil, require_authorization: nil, updated: nil}

    def endpoint_fixture(attrs \\ %{}) do
      {:ok, endpoint} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Communication.create_endpoint()

      endpoint
    end

    test "list_endpoints/0 returns all endpoints" do
      endpoint = endpoint_fixture()
      assert Communication.list_endpoints() == [endpoint]
    end

    test "get_endpoint!/1 returns the endpoint with given id" do
      endpoint = endpoint_fixture()
      assert Communication.get_endpoint!(endpoint.id) == endpoint
    end

    test "create_endpoint/1 with valid data creates a endpoint" do
      assert {:ok, %Endpoint{} = endpoint} = Communication.create_endpoint(@valid_attrs)
      assert endpoint.accept_any_message_type == true
      assert endpoint.active == true
      assert endpoint.controlled == true
      assert endpoint.created == ~D[2010-04-17]
      assert endpoint.created_by == "some created_by"
      assert endpoint.description == "some description"
      assert endpoint.message_type == "some message_type"
      assert endpoint.name == "some name"
      assert endpoint.require_authorization == true
      assert endpoint.updated == ~D[2010-04-17]
    end

    test "create_endpoint/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Communication.create_endpoint(@invalid_attrs)
    end

    test "update_endpoint/2 with valid data updates the endpoint" do
      endpoint = endpoint_fixture()
      assert {:ok, %Endpoint{} = endpoint} = Communication.update_endpoint(endpoint, @update_attrs)
      assert endpoint.accept_any_message_type == false
      assert endpoint.active == false
      assert endpoint.controlled == false
      assert endpoint.created == ~D[2011-05-18]
      assert endpoint.created_by == "some updated created_by"
      assert endpoint.description == "some updated description"
      assert endpoint.message_type == "some updated message_type"
      assert endpoint.name == "some updated name"
      assert endpoint.require_authorization == false
      assert endpoint.updated == ~D[2011-05-18]
    end

    test "update_endpoint/2 with invalid data returns error changeset" do
      endpoint = endpoint_fixture()
      assert {:error, %Ecto.Changeset{}} = Communication.update_endpoint(endpoint, @invalid_attrs)
      assert endpoint == Communication.get_endpoint!(endpoint.id)
    end

    test "delete_endpoint/1 deletes the endpoint" do
      endpoint = endpoint_fixture()
      assert {:ok, %Endpoint{}} = Communication.delete_endpoint(endpoint)
      assert_raise Ecto.NoResultsError, fn -> Communication.get_endpoint!(endpoint.id) end
    end

    test "change_endpoint/1 returns a endpoint changeset" do
      endpoint = endpoint_fixture()
      assert %Ecto.Changeset{} = Communication.change_endpoint(endpoint)
    end
  end
end
