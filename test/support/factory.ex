defmodule Flightex.Factory do
  use ExMachina

  alias Flightex.Bookings.Booking
  alias Flightex.Users.User

  def user_factory do
    %User{
      id: UUID.uuid4(),
      name: "Gui",
      email: "gui@gui.com",
      cpf: "12345678900"
    }
  end

  def booking_factory do
    %Booking{
      data_completa: ~N[2021-03-03 03:03:03],
      cidade_origem: "São Paulo",
      cidade_destino: "Rio de Janeiro",
      id_usuario: "1111111111111",
      id: UUID.uuid4()
    }
  end
end
