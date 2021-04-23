defmodule Happ.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Happ.Repo,

      # Start the Telemetry supervisor
      HappWeb.Telemetry,

      # Start the PubSub system
      {Phoenix.PubSub, name: Happ.PubSub},

      # Start the Endpoint (http/https)
      HappWeb.Endpoint,

      # Start Elasticsearch
      Happ.Elasticsearch.Cluster,

      # Start a worker by calling: Happ.Worker.start_link(arg)
      # {Happ.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Happ.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    HappWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
