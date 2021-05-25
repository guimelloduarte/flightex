defmodule Flightex.Bookings.AgentTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Bookings.Agent, as: BookingAgent

  describe "save/1" do
    setup do
      BookingAgent.start_link(%{})

      :ok
    end

    test "when all params are valid, returns a booking" do
      booking = build(:booking)

      assert {:ok, _id} = BookingAgent.save(booking)
    end
  end

  describe "get/1" do
    setup do
      BookingAgent.start_link(%{})

      :ok
    end

    test "when the booking is found, returns the booking" do
      booking = build(:booking)
      {:ok, id} = BookingAgent.save(booking)

      response = BookingAgent.get(id)

      expected_response = {:ok, booking}

      assert response == expected_response
    end

    test "when the booking is not found, returns an error" do
      response = BookingAgent.get("0000000000")

      expected_response = {:error, "Flight Booking not found"}

      assert response == expected_response
    end
  end
end
