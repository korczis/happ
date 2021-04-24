defmodule Happ.Crawler.Response do
  @moduledoc """
  Response from crawler.
  """

  defstruct [
    request: nil,
    results: nil,
    next: nil
  ]
end
