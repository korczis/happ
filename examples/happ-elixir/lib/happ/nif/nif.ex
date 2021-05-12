defmodule Happ.Nif do
  @on_load :load_nifs

  @moduledoc """
  Stub for native functions implemented using ANSI C.
  """

  def load_nifs do
    :erlang.load_nif('./native-c/build/happ', 0)
  end

  def fast_compare(_a, _b) do
    raise "NIF fast_compare/2 not implemented"
  end
end