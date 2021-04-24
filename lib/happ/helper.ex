defmodule Happ.Helper do
  def test() do
    [
      DynamicSupervisor.start_child(Happ.DynamicSupervisor, {Happ.Otp.Agent.Counter, 0}),
      DynamicSupervisor.start_child(Happ.DynamicSupervisor, {Happ.Otp.Agent.Crawler, %{}})
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