defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def create(filename \\ "report.csv") do
    booking_list = build_booking_list()

    File.write(filename, booking_list)
  end

  defp build_booking_list() do
    BookingAgent.list_all()
    |> Map.values()
    |> Enum.map(&booking_string(&1))
  end

  defp booking_string(%Booking{
         id_usuario: id_usuario,
         cidade_origem: cidade_origem,
         cidade_destino: cidade_destino,
         data_completa: data_completa
       }) do
    "#{id_usuario},#{cidade_origem},#{cidade_destino},#{data_completa}\n"
  end
end
