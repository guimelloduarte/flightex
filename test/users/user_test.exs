defmodule Flightex.Users.UserTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Users.User

  describe "build/3" do
    test "when all params are valid returns the user" do
      {_ok, response} = User.build("Gui", "gui@gui.com", "12345678900")

      expected_response = build(:user, id: response.id)

      assert response == expected_response
    end

    test "when cpf is a integer" do
      response =
        User.build(
          "Gui",
          "gui@gui.com",
          112_250_055
        )

      expected_response = {:error, "Cpf must be a String"}

      assert response == expected_response
    end
  end
end
