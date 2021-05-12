defmodule AddStruct do
  @moduledoc """
  Result metadata.
  """

  defstruct [
    lhs: nil,
    rhs: nil
  ]

  @type t() :: %__MODULE__{
                 lhs: integer(),
                 rhs: integer(),
               }
end

defmodule Happ.Native do

  @moduledoc """
  Stub for native functions implemented using Rustler.
  """

  use Rustler,
      otp_app: :happ,
      crate: "happ_native"

  defp err do
    throw(NifNotLoadedError)
  end

  # When your NIF is loaded, it will override these functions.

  # Basic math functions
  def add(_, _), do: err()
  def div(_, _), do: err()
  def mul(_, _), do: err()
  def sub(_, _), do: err()

  # Advanced math functions
  def sum_list(_), do: err()

  # Struct functions
  def struct_echo(_), do: err()
end