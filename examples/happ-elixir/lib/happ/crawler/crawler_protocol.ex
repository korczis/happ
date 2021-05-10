defprotocol Happ.Crawler.CrawlerProtocol do
  @doc "Crawls specific URL"
  @spec crawl(binary()) :: Happ.Crawler.Response.t()
  def crawl(arg)
end