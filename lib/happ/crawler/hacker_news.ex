defmodule Happ.Crawler.HackerNews do
  @derive [Happ.Crawler.Crawler]

  @moduledoc """
  Crawler for https://news.ycombinator.com/.
  """

  @base_url "https://news.ycombinator.com/"

  #  @spec crawl(binary() | Happ.Crawler.Result | [Happ.Crawler.Result]) :: [Happ.Crawler.Result]
  #  def crawl(arg \\ @base_url) do
  #    case arg do
  #      nil -> []
  #      args = [%Happ.Crawler.Result{}] -> Enum.flat_map(args, fn item -> crawl(item) end)
  #      %{next: next_urls} ->
  #        Enum.flat_map(next_urls, fn url -> crawl(url) end)
  #      url -> crawl_impl(url)
  #    end
  #  end

  @spec process(String.t()) :: Happ.Crawler.Result
  def process(url \\ @base_url) do
    {:ok, resp} = HTTPoison.get(url)
    {:ok, document} = Floki.parse_document(resp.body)

    uri = URI.parse(url)

    extract_data = fn match ->
      href = URI.parse(List.first(Floki.attribute(match, "href")))
      next_url = URI.merge(uri, href)

      %{
        title: Floki.text(match),
        url: URI.to_string(next_url)
      }
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

    %Happ.Crawler.Result{
      crawler: __MODULE__,
      url: url,
      next: [%{
        url: more_link_url,
        crawler: __MODULE__
      }],
      data: data
    }
  end
end
