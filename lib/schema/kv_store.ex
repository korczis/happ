defmodule Happ.KvPair do
  use Ecto.Schema

  schema "kv_store" do
    field :key, :string
    field :value, :string

    timestamps()
  end
end