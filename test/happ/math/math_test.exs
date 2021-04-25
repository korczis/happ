defmodule Happ.Math.Test do
  use ExUnit.Case

  alias Happ.Math

  test "factorial" do
    assert Math.factorial(6) == 720
  end

  test "gcd" do
    assert Math.gcd(15, 20) == 5
  end
end