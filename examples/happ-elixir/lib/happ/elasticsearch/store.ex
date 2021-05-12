defmodule Happ.Elasticsearch.Store do
  @moduledoc """
  Customized implementation Elasticsearch.Store behaviour.
  """

  @behaviour Elasticsearch.Store

  import Ecto.Query

  alias Happ.Repo

  @impl true
  def stream(schema) do
    Repo.stream(schema)
  end

  @impl true
  def transaction(fun) do
    {:ok, result} = Repo.transaction(fun, timeout: :infinity)
    result
  end
end