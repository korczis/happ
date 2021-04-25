defmodule Happ.Native.Test do
  use ExUnit.Case

  alias Happ.Native

  test "add" do
    assert Native.add(1, 2) == {:ok, 3}
  end
end