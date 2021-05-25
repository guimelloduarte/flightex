defmodule Flightex.Users.User do
  @keys [:id, :name, :email, :cpf]
  @enforce_keys @keys

  defstruct @keys

  def build(name, email, cpf) when is_bitstring(cpf) do
    id = UUID.uuid4()
    build_user(id, name, email, cpf)
  end

  def build(_name, _email, _cpf), do: {:error, "Cpf must be a String"}

  defp build_user(id, name, email, cpf) do
    {:ok, %__MODULE__{id: id, name: name, email: email, cpf: cpf}}
  end
end
