defmodule Flightex.Bookings.CreateOrUpdate do
  alias Flightex.Bookings.Booking
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Users.Agent, as: UserAgent

  def call(
        %{
          year: year,
          month: month,
          day: day,
          hour: hour,
          minute: minute,
          second: second,
          cidade_origem: cidade_origem,
          cidade_destino: cidade_destino
        },
        id_usuario
      ) do
    with {:ok, user} <- UserAgent.get(id_usuario),
         {:ok} <- check_cities(cidade_origem, cidade_destino),
         {:ok, booking} <-
           Booking.build(
             year,
             month,
             day,
             hour,
             minute,
             second,
             cidade_origem,
             cidade_destino,
             user
           ) do
      BookingAgent.save(booking)
    end
  end

  defp check_cities(cidade_origem, cidade_destino) do
    case cidade_origem == cidade_destino do
      true ->
        {:error, "You need to choose different cities to book a Flight"}

      false ->
        {:ok}
    end
  end
end
