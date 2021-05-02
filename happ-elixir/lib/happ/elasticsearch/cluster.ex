defmodule Happ.Elasticsearch.Cluster do
  @moduledoc """
  Customized Elasticsearch.Cluster wrapper.
  """

  use Elasticsearch.Cluster, otp_app: :happ
end