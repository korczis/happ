defmodule Happ.Crawler.Result do
  @moduledoc """
  Crawling result.
  """

  @enforce_keys [:meta, :data, :request]
  defstruct [
    meta: nil,
    data: nil,
    request: nil
  ]

  @type t() :: %__MODULE__{
                 meta: Happ.Crawler.ResultMeta.t(),
                 data: map(),
                 request: Happ.Crawler.Request.t()
               }
end

defimpl Elasticsearch.Document, for: Happ.Crawler.Result do
  def id(result), do: result.meta.id
  def routing(_), do: false
  def encode(result), do: result
end