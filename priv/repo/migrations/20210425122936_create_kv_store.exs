defmodule Happ.Repo.Migrations.CreateKvStore do
  use Ecto.Migration

  def change do
    create table(:kv_store) do
      add :key, :string
      add :value, :string

      timestamps()
    end
  end
end
