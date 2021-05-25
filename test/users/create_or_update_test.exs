defmodule Flightex.Users.CreateOrUpdateTest do
  use ExUnit.Case, async: true

  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.CreateOrUpdate

  describe "call/1" do
    setup do
      UserAgent.start_link(%{})
      :ok
    end

    test "when paramameters are valid, returns a tuple" do
      params = %{name: "Gui", email: "gui@gui.com", cpf: "12345678900"}

      CreateOrUpdate.call(params)

      response = UserAgent.get(params)

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end

    test "when a cpf is an integer, returns an error" do
      params = %{name: "Gui", email: "gui@gui.com", cpf: 12_345_678_900}

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "Cpf must be a String"}

      assert response == expected_response
    end
  end
end
