defprotocol Happ.Crawler.Crawler do
  @doc "Crawls specific URL"
  @spec process(String.t()) :: Happ.Crawler.Result
  def process(arg)
end