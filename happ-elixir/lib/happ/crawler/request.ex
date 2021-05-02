defmodule Happ.Crawler.Request do
  @moduledoc """
  Request for crawling.
  """
  @enforce_keys [:url, :crawler]
  defstruct [
    url: nil,
    crawler: nil
  ]

  @type t() :: %__MODULE__{
                 url: String.t(),
                 crawler: module()
               }
end
