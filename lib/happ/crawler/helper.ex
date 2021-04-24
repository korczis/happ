defmodule Happ.Crawler.Helper do
  @moduledoc """
  Helper to make crawling easier.
  """

  def crawl(%{crawler: crawler, url: url}) do
    crawl(crawler, url)
  end

  def crawl(crawler, url) do
    apply(crawler, :process, [url])
  end
end
