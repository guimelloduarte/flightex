defmodule Flightex.Bookings.Agent do
  use Agent

  alias Flightex.Bookings.Booking

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%Booking{id: id} = booking) do
    Agent.update(__MODULE__, &update_state(&1, booking, id))

    {:ok, id}
  end

  defp update_state(state, %Booking{} = booking, id), do: Map.put(state, id, booking)

  def get(id), do: Agent.get(__MODULE__, &get_order(&1, id))

  def list_all, do: Agent.get(__MODULE__, & &1)

  defp get_order(state, id) do
    case Map.get(state, id) do
      nil ->
        {:error, "Flight Booking not found"}

      booking ->
        {:ok, booking}
    end
  end
end
