defmodule Happ.Crawler.Helper do
  @moduledoc """
  Helper to make crawling easier.
  """

  @spec crawl(Happ.Crawler.Request.t()) :: any()
  def crawl(request) do
    crawl(request.crawler, request.url)
  end

  @spec crawl(module(), String.t()) :: any()
  def crawl(crawler, url) do
    apply(crawler, :crawl, [url])
  end

  @spec construct_response(Happ.Crawler.Request.t(), [Happ.Crawler.Request.t()],  [Happ.Crawler.Result.t()]) :: Happ.Crawler.Response.t()
  def construct_response(request, next, results) do
    %Happ.Crawler.Response{
      request: request,
      next: next,
      results: results
    }
  end

  @spec construct_result(any(), any(), %Happ.Crawler.ResultMeta{}) :: Happ.Crawler.Result.t()
  def construct_result(request, data, meta \\ %Happ.Crawler.ResultMeta{}) do
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
