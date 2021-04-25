defmodule Happ.Crawler.Result do
  @moduledoc """
  Crawling result.
  """

  defstruct [
    meta: nil,
    data: nil,
    request: nil
  ]
end

defimpl Elasticsearch.Document, for: Happ.Crawler.Result do
  def id(result), do: result.meta.id
  def routing(_), do: false
  def encode(result), do: result
end