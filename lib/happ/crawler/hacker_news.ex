defmodule Happ.Crawler.Result do
  @moduledoc """
  Crawling result.
  """

  defstruct [:next, :data]
end

defmodule Happ.Crawler.HackerNews do
  @moduledoc """
  Crawler for https://news.ycombinator.com/.
  """

  @base_url "https://news.ycombinator.com/"

  def crawl do
    {:ok, resp} = HTTPoison.get(@base_url)
    {:ok, document} = Floki.parse_document(resp.body)

    match_titles = Floki.find(document, "a.storylink")
    titles = Enum.map(match_titles, fn match -> Floki.text(match) end)

    match_morelink = Floki.find(document, "a.morelink")
    titles = Enum.map(match_titles, fn match -> Floki.text(match) end)

    more_link_href = match_morelink
                     |> Floki.attribute("href")

    more_link_url = "#{@base_url}#{more_link_href}"

    %Happ.Crawler.Result{
      next: more_link_url,
      data: titles
    }
  end
end
