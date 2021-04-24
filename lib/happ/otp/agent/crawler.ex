defmodule Happ.Otp.Agent.Crawler do
  use Agent

  def start_link(initial_value \\ %{}) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  def crawl(request) do
    Agent.update(
      __MODULE__,
      fn state ->
        result = Happ.Crawler.Helper.crawl(request)
        Map.merge(
          state,
          Map.put(%{}, request.crawler, result)
        )
      end
    )
  end

  def crawl_next(crawler) do
    Agent.update(
      __MODULE__,
      fn state ->
        {:ok, prev_result} = Map.fetch(state, crawler)
        result = Happ.Crawler.Helper.crawl(List.first(prev_result.next))
        Map.merge(
          state,
          Map.put(%{}, crawler, result)
        )
      end
    )
  end

  def crawl_result(crawler) do
    Agent.get(
      __MODULE__,
      fn state ->
        Map.fetch(state, crawler)
      end
    )
  end

end