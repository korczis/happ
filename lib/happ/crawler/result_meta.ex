defmodule Happ.Crawler.ResultMeta do
  @moduledoc """
  Result metadata.
  """

  # @enforce_keys [:id, :version]
  defstruct [
    id: nil,
    created_at: nil,
    updated_at: nil,
    version: nil,
  ]

  @type t() :: %__MODULE__{
                 id: String.t(),
                 created_at: integer(),
                 updated_at: integer(),
                 version: integer()
               }
end
