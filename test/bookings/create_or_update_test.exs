defmodule FLightex.Bookings.CreateOrUpdateTest do
  use ExUnit.Case, async: false

  import Flightex.Factory

  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Bookings.CreateOrUpdate

  describe "call/1" do
    setup do
      user = build(:user)

      Flightex.start_agent()

      UserAgent.save(user)

      params = %{
        year: 2020,
        month: 3,
        day: 3,
        hour: 3,
        minute: 3,
        second: 3,
        cidade_origem: "São Paulo",
        cidade_destino: "Rio de Janeiro"
      }

      {:ok, id_usuario: user.id, params: params}
    end

    test "when all params are valid, saves the booking", %{params: params, id_usuario: id_usuario} do
      response = CreateOrUpdate.call(params, id_usuario)

      assert {:ok, _id} = response
    end

    test "when chooses the same city returns an error", %{params: params, id_usuario: id_usuario} do
      response = CreateOrUpdate.call(%{params | cidade_destino: "São Paulo"}, id_usuario)

      assert response == {:error, "You need to choose different cities to book a Flight"}
    end
  end
end
