defmodule Happ.Native do

  @moduledoc """
  Stub for native functions implemented using Rustler.
  """

  use Rustler, otp_app: :happ, crate: "happ_native"

  # When your NIF is loaded, it will override this function.
  def add(_a, _b), do: :erlang.nif_error(:nif_not_loaded)
end