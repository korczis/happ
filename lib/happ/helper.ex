defmodule Happ.Helper do
  def test() do
    # See https://hexdocs.pm/horde/readme.html
    [
      # DynamicSupervisor.start_child(Happ.DynamicSupervisor, {Happ.Otp.Agent.Counter, 0}),
      # DynamicSupervisor.start_child(Happ.DynamicSupervisor, {Happ.Otp.Agent.Crawler, %{}})

      Horde.DynamicSupervisor.start_child(
        Happ.DistributedSupervisor,
        %{
          id: :agent,
          start: {
            Happ.Otp.Agent.Counter, :start_link, [fn -> 0 end]
          }
        }
      ),

      Horde.DynamicSupervisor.start_child(
        Happ.DistributedSupervisor,
        %{
          id: :agent,
          start: {
            Happ.Otp.Agent.Crawler, :start_link, [fn -> %{} end]
          }
        }
      )
    ]
  end

  def test_agent_crawler() do
    # {:ok, agent} = DynamicSupervisor.start_child(Happ.DynamicSupervisor, {Happ.Otp.Agent.Crawler, fn -> %{} end})

    Happ.Otp.Agent.Crawler.crawl(%Happ.Crawler.Request{
      crawler: Happ.Crawler.HackerNews,
      url: "https://news.ycombinator.com/news"
    })
  end
end