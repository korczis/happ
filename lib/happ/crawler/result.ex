defmodule Happ.Crawler.Result do
  @moduledoc """
  Crawling result.
  """

  defstruct [
    url: nil,
    crawler: nil,
    next: [],
    data: []
  ]
end
