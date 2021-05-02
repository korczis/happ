defmodule Happ.Crawler.Stream do
  @moduledoc """
  Crawling stream.
  """

  # See https://github.com/humpangle/github_stream/tree/15efbafc63512443f14699cfd4ec9691c0c8928d/lib

  def crawl(request) do
    Stream.resource(
      fn -> crawler_fetch(request) end,
      &crawler_process_response/1,
      fn _ -> nil end
    )
  end

  defp crawler_fetch(request) do
    IO.puts("crawler_fetch - request (#{inspect(request)})")
    response = Happ.Crawler.Helper.crawl(request)
    IO.puts("crawler_fetch - response (#{inspect(response)})")

    {response.results, List.first(response.next)}
  end

  defp crawler_process_response({items, next_request}) do
    case {items, next_request} do
      {nil, nil} ->
        {:halt, nil}

      {nil, next_request} ->
        {next_items, next_link} = crawler_fetch(next_request)
        {next_items, {nil, next_link}}

      _ ->
        {items, {nil, next_request}}
    end
  end
end
