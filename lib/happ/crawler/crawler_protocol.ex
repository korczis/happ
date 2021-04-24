defprotocol Happ.Crawler.CrawlerProtocol do
  @doc "Crawls specific URL"
  @spec process(String.t()) :: Happ.Crawler.Response
  def process(arg)
end