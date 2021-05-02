defmodule Happ.Math do
  @moduledoc """
  Basic mathematics functions.
  """

  @doc """
  Factorial

  ## Parameters

    - n: Number to calculate factorial of

  ## Examples

      iex> Happ.Math.factorial(6)
      720

  """
  @spec factorial(integer()) :: integer()
  def factorial(n) do
    case n do
      0 -> 1
      _ -> n * factorial(n - 1)
    end
  end

  @doc """
  GCD - Greatest common divisor of two numbers

  In mathematics, the greatest common divisor (GCD) of two or more integers,
  which are not all zero, is the largest positive integer that divides each of the integers.

  ## Parameters

    - x: First number
    - y: Second number

  ## Examples

      iex> Happ.Math.gcd(16, 72)
      8

  """
  @spec gcd(integer(), integer()) :: integer()
  def gcd(x, y) do
    case {x, y} do
      {x, 0} -> x
      _ -> gcd(y, rem(x, y))
    end
  end

  @doc """
  LCM - Least common multiple

  In arithmetic and number theory, the least common multiple, lowest common multiple,
  or smallest common multiple of two integers x and y, usually denoted by lcm(x, y),
  is the smallest positive integer that is divisible by both x and y.

  ## Parameters

    - x: First number
    - y: Second number

  ## Examples

      iex>  Happ.Math.lcm(18, 22)
      198.0

  """
  @spec lcm(integer(), integer()) :: float()
  def lcm(x, y) do
    (x * y) / gcd(x, y)
  end

  @doc """
  Linear interpolation

  Precise method, which guarantees v = v1 when t = 1. This method is monotonic only when v0 * v1 < 0.
  Lerping between same values might not produce the same value.

  ## Parameters

    - x: Left side of interval
    - y: Right side of interval
    - t: Position in interval (0.0 - 1.0)

  ## Examples

      iex>   Happ.Math.lerp(5, 10, 0.5)
      7.5

  """
  @spec lerp(integer() | float(), integer() | float(), float()) :: integer() | float()
  def lerp(x, y, t) do
    (1 - t) * x + t * y
  end
end