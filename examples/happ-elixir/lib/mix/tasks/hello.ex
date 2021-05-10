defmodule Mix.Tasks.Hello do
  use Mix.Task

  @shortdoc "Greeter"

  @moduledoc """
  Say hello world.
  """
  def run(_args) do
    IO.puts("Hello, world!")

    :ok
  end
end