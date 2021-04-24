# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

#config :elastix,
#       shield: true,
#       username: "username",
#       password: "password"

config :happ, Happ.Elasticsearch.Cluster      ,
       # The URL where Elasticsearch is hosted on your system
       url: System.get_env("ELASTICSEARCH_URL", "http://localhost:9200"),

         # If your Elasticsearch cluster uses HTTP basic authentication,
         # specify the username and password here:
       username: System.get_env("ELASTICSEARCH_USERNAME", "username"),
       password: System.get_env("ELASTICSEARCH_PASSWORD", "password"),

         # If you want to mock the responses of the Elasticsearch JSON API
         # for testing or other purposes, you can inject a different module
         # here. It must implement the Elasticsearch.API behaviour.
       api: Elasticsearch.API.HTTP,

         # Customize the library used for JSON encoding/decoding.
       json_library: Poison, # or Jason

       default_options: [
              timeout: 5_000,
              recv_timeout: 5_000,
              hackney: [pool: :pool_name]
       ]

         # You should configure each index which you maintain in Elasticsearch here.
         # This configuration will be read by the `mix elasticsearch.build` task,
         # described below.
#       indexes: %{
#         # This is the base name of the Elasticsearch index. Each index will be
#         # built with a timestamp included in the name, like "posts-5902341238".
#         # It will then be aliased to "posts" for easy querying.
#         posts: %{
#           # This file describes the mappings and settings for your index. It will
#           # be posted as-is to Elasticsearch when you create your index, and
#           # therefore allows all the settings you could post directly.
#           settings: "priv/elasticsearch/posts.json",
#
#           # This store module must implement a store behaviour. It will be used to
#           # fetch data for each source in each indexes' `sources` list, below:
#           store: MyApp.ElasticsearchStore,
#
#           # This is the list of data sources that should be used to populate this
#           # index. The `:store` module above will be passed each one of these
#           # sources for fetching.
#           #
#           # Each piece of data that is returned by the store must implement the
#           # Elasticsearch.Document protocol.
#           sources: [MyApp.Post],
#
#           # When indexing data using the `mix elasticsearch.build` task,
#           # control the data ingestion rate by raising or lowering the number
#           # of items to send in each bulk request.
#           bulk_page_size: 5000,
#
#           # Likewise, wait a given period between posting pages to give
#           # Elasticsearch time to catch up.
#           bulk_wait_interval: 15_000 # 15 seconds
#         }
#       }

config :happ,
       ecto_repos: [Happ.Repo]

config :happ, :elasticsearch,
       url: System.get_env("ELASTICSEARCH_URL", "http://localhost:9200")

# Configures the endpoint
config :happ, HappWeb.Endpoint,
       url: [host: "localhost"],
       secret_key_base: "poGBa+wu1Cea7inDeebz4i4+dpOx3YmnF5BeQOpQnUVBNTrzZxwQM2qA2m5ZZagM",
       render_errors: [view: HappWeb.ErrorView, accepts: ~w(html json), layout: false],
       pubsub_server: Happ.PubSub,
       live_view: [signing_salt: "l5ddAgRI"]

# Configures Elixir's Logger
config :logger, :console,
       format: "$time $metadata[$level] $message\n",
       metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
