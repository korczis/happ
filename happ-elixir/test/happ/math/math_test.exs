defmodule Happ.Math.Test do
  use ExUnit.Case

  alias Happ.Math

  test "factorial" do
    assert Math.factorial(6) == 720
  end

  test "gcd" do
    assert Math.gcd(15, 20) == 5
  end

  test "lcm" do
    assert Math.lcm(15, 20) == 60
  end

  test "lerp" do
    assert Math.lerp(5, 10, 0.5) == 7.5
  end
end