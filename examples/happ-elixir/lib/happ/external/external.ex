alias Porcelain.Result
alias Porcelain.Process, as: Proc

defmodule Happ.External do
  @moduledoc """
  Examples of interaction with external (OS) processes.
  """

  def date() do
    %Result{out: output, status: _status} = Porcelain.shell("date")
    IO.puts output
  end

  def ping(hostname \\ "google.com") do
    # instream = SocketStream.new('example.com', 80)
    # opts = [in: instream, out: :stream]

    opts = [out: :stream]
    _proc = %Proc{out: outstream} = Porcelain.spawn("ping", ["-c", "3", hostname], opts)

    Enum.into(outstream, IO.stream(:stdio, :line))

    :ok
  end
end