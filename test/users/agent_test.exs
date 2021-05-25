defmodule Flightex.Users.AgentTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Users.Agent, as: UserAgent

  describe "save/1" do
    setup do
      UserAgent.start_link(%{})

      id = UUID.uuid4()

      {:ok, id: id}
    end

    test "when the user is saved returns a tuple", %{id: id} do
      :user
      |> build(id: id)
      |> UserAgent.save()

      response = UserAgent.get(id)

      expected_response =
        {:ok, %Flightex.Users.User{cpf: "12345678900", email: "gui@gui.com", id: id, name: "Gui"}}

      assert response == expected_response
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(%{})

      id = UUID.uuid4()

      {:ok, id: id}
    end

    test "when the user is found, returns the user", %{id: id} do
      :user
      |> build(id: id)
      |> UserAgent.save()

      response = UserAgent.get(id)

      expected_response =
        {:ok, %Flightex.Users.User{cpf: "12345678900", email: "gui@gui.com", id: id, name: "Gui"}}

      assert response == expected_response
    end

    test "when the user is not found returns an error", %{id: id} do
      :user
      |> build(id: id)
      |> UserAgent.save()

      response = UserAgent.get("1111111")

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end
end
