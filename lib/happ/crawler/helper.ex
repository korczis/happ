defmodule Happ.Crawler.Helper do
  @moduledoc """
  Helper to make crawling easier.
  """

  def crawl(%Happ.Crawler.Request{crawler: crawler, url: url}) do
    crawl(crawler, url)
  end

  def crawl(crawler, url) do
    apply(crawler, :crawl, [url])
  end

  def construct_response(request, next, results) do
    %Happ.Crawler.Response{
      request: request,
      next: next,
      results: results
    }
  end

  def construct_result(request, data, meta \\ %{}) do
    now =  DateTime.utc_now |> DateTime.to_unix

    %Happ.Crawler.Result{
      meta: Map.merge(%{
        id: UUID.uuid4(),
        created_at: now,
        updated_at: now,
        version: 1,
      }, meta),

      request: request,

      data: data
    }
  end

  def test_supervisor() do
    # Start the server
    {:ok, pid} = DynamicSupervisor.start_child(Happ.DynamicSupervisor, {Happ.Crawler.Worker, fn -> %{} end})

    # This is the client
    GenServer.call(pid, :pop)
    #=> :hello

    GenServer.cast(pid, {:push, :world})
    #=> :ok

    GenServer.call(pid, :pop)
    #=> :world
  end
end
