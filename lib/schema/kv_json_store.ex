defmodule Happ.KvJsonPair do
  use Ecto.Schema

  schema "kv_json_store" do
    field :key, :string
    field :value, :map

    timestamps()
  end
end