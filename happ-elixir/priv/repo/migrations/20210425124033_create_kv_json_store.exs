defmodule Happ.Repo.Migrations.CreateKvJsonStore do
  use Ecto.Migration

  def change do
    create table(:kv_json_store) do
      add :key, :string
      add :value, :map

      timestamps()
    end
  end
end
