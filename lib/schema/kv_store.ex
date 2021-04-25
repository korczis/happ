defmodule Happ.KvPair do
  @moduledoc """
  Schema for Ecto Key Value Store - String -> String.
  """

  use Ecto.Schema

  schema "kv_store" do
    field :key, :string
    field :value, :string

    timestamps()
  end
end