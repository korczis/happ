defmodule Happ.Crawler.HackerNews do
  @derive [Happ.Crawler.CrawlerProtocol]

  @moduledoc """
  Crawler for https://news.ycombinator.com/.
  """

  @base_url "https://news.ycombinator.com/"

  @spec crawl(String.t()) :: Happ.Crawler.Result
  def crawl(url \\ @base_url) do
    IO.puts("Crawling URL #{url}")

    {:ok, resp} = HTTPoison.get(url)
    {:ok, document} = Floki.parse_document(resp.body)

    uri = URI.parse(url)

    request = %Happ.Crawler.Request{
      crawler: __MODULE__,
      url: url
    }

    extract_data = fn match ->
      href = URI.parse(List.first(Floki.attribute(match, "href")))
      next_url = URI.merge(uri, href)

      Happ.Crawler.Helper.construct_result(
        request,
        %{
          title: Floki.text(match),
          url: URI.to_string(next_url)
        }
      )
    end

    match_titles = Floki.find(document, "a.storylink")
    data = Enum.map(
      match_titles,
      fn match -> extract_data.(match) end
    )

    match_morelink = Floki.find(document, "a.morelink")
    more_link_href = match_morelink
                     |> Floki.attribute("href")

    more_link_url = "#{@base_url}#{more_link_href}"

    next = [%Happ.Crawler.Request{
      url: more_link_url,
      crawler: __MODULE__
    }]

    Happ.Crawler.Helper.construct_response(request, next, data)
  end
end

## Response
#%{
#  request: %Happ.Crawler.Request,
#  next: [],
#  results: []
#}
#
### Result
#%{
#  meta: %{
#    id: nil,
#    created_at: nil,
#    updated_at: nil,
#    version: nil,
#  },
#
#  data: %{
#
#  }
#}

