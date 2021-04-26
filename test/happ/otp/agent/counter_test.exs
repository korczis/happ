defmodule Happ.Otp.Agent.Counter.Test do
  use ExUnit.Case

  alias Happ.Otp.Agent.Counter

  # "setup_all" is called once per module before any test runs
  setup_all do
    Horde.DynamicSupervisor.start_child(
      Happ.DistributedSupervisor,
      %{
        id: :agent,
        start: {
          Happ.Otp.Agent.Counter, :start_link, [0] # [fn -> 0 end]
        }
      }
    )

    # Context is not updated here
    :ok
  end

  test "value" do
    assert Happ.Otp.Agent.Counter.value() == 0
  end

  test "increment" do
    Happ.Otp.Agent.Counter.increment()
    assert Happ.Otp.Agent.Counter.value() == 1
  end
end