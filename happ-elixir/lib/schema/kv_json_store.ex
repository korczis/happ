defmodule Happ.KvJsonPair do
  @moduledoc """
  Schema for Ecto Key Value Store - String -> Map/JSON.
  """

  use Ecto.Schema

  schema "kv_json_store" do
    field :key, :string
    field :value, :map

    timestamps()
  end
end