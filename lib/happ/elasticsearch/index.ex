defmodule Happ.Elasticsearch.Index do
  @moduledoc """
  Elasticsearch Index Helper.
  """

  def create(name, opts \\ %{}) do
    Elastix.Index.create(Application.get_env(:happ, :elasticsearch)[:url], name, opts)
  end
end