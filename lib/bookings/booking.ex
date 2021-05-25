defmodule Flightex.Bookings.Booking do
  alias Flightex.Users.User

  @cidades [
    "Belo Horizonte",
    "Brasília",
    "Campinas",
    "Fortaleza",
    "Manaus",
    "Porto Alegre",
    "Rio de Janeiro",
    "São Paulo"
  ]

  @keys [:id, :data_completa, :cidade_origem, :cidade_destino, :id_usuario]

  @enforce_keys @keys

  defstruct @keys

  def build(year, month, day, hour, minute, second, cidade_origem, cidade_destino, %User{id: id})
      when cidade_origem in @cidades and cidade_destino in @cidades and
             cidade_destino != cidade_origem do
    year
    |> NaiveDateTime.new(month, day, hour, minute, second)
    |> build_ticket(cidade_origem, cidade_destino, id)
  end

  defp build_ticket({:ok, data_completa}, cidade_origem, cidade_destino, id) do
    {:ok,
     %__MODULE__{
       id: UUID.uuid4(),
       data_completa: data_completa,
       cidade_origem: cidade_origem,
       cidade_destino: cidade_destino,
       id_usuario: id
     }}
  end

  defp build_ticket({:error, _reason}, _cidade_origem, _cidade_destino, _id),
    do: {:error, "Ivalid Date or Time"}
end
