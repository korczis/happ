defmodule Math do
  def factorial(n) do
    case n do
      0 -> 1
      _ -> n * factorial(n - 1)
    end
  end

  def gcd(x, y) do
    case {x, y} do
      {x, 0} -> x
      _ -> gcd(y, rem(x, y))
    end
  end
end