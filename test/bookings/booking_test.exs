defmodule Flightex.Bookings.BookingTest do
  use ExUnit.Case, async: false

  import Flightex.Factory

  alias Flightex.Bookings.Booking

  describe "build/9" do
    test "when all params are valid, returns a booking" do
      {_ok, response} =
        Booking.build(2021, 3, 3, 3, 3, 3, "São Paulo", "Rio de Janeiro", build(:user))

      expected_response = %Booking{
        cidade_destino: "Rio de Janeiro",
        cidade_origem: "São Paulo",
        data_completa: ~N[2021-03-03 03:03:03],
        id: response.id,
        id_usuario: response.id_usuario
      }

      assert response == expected_response
    end
  end
end
