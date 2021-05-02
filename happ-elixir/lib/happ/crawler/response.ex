defmodule Happ.Crawler.Response do
  @moduledoc """
  Response from crawler.
  """

  @enforce_keys [:request, :results, :next]
  defstruct [
    request: nil,
    results: nil,
    next: nil
  ]

  @type t() :: %__MODULE__{
                 request: %Happ.Crawler.Request{},
                 results: [%Happ.Crawler.Result{}],
                 next: %Happ.Crawler.Request{}
               }
end
