defmodule Mix.Tasks.Compile.Nifs do
  use Mix.Task

  @shortdoc "Compile custom NIFs"

  @moduledoc """
  Compile custom NIFs.
  """
  def run(_args) do
    {:ok, cwd} = File.cwd
    build_dir = Path.join(["native-c", "build"])

    IO.puts("= Creating build folder #{build_dir} =")
    File.mkdir_p!(build_dir)
    IO.puts("")

    IO.puts("= Generating Makefile =")
    File.cd(build_dir)
    System.cmd("cmake", [".."], into: IO.stream(:stdio, :line))
    IO.puts("")

    IO.puts("= Compiling NIFs =")
    System.cmd("make", [], into: IO.stream(:stdio, :line))
    IO.puts("")

    File.cd(cwd)

    :ok
  end
end

defmodule Mix.Tasks.Compile.Wasm do
  use Mix.Task

  @shortdoc "Build WebAssembly "

  @moduledoc """
  Build WebAssembly package and related stuff.
  """
  def run(_args) do
    {:ok, cwd} = File.cwd
    build_dir = Path.join(["assets", "wasm"])
    IO.puts("CHANGING DIR (build_dir) - #{build_dir}")
    File.cd(build_dir)

    System.cmd("wasm-pack", ["build"])
    IO.puts("")

    File.cd(cwd)

    www_dir = Path.join(["assets", "wasm", "www"])
    IO.puts("CHANGING DIR (build_dir) - #{www_dir}")
    File.cd(www_dir)

    System.cmd("yarn", [])
    IO.puts("")

    System.cmd("npm", ["run", "build"])
    IO.puts("")

    File.cd(cwd)

    :ok
  end
end

defmodule Happ.MixProject do
  use Mix.Project

  def extra_compilers do
    [
      :rustler,
      :nifs,
      # :wasm
    ]
  end

  def project do
    [
      app: :happ,
      version: "0.1.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ extra_compilers() ++ Mix.compilers(),

      rustler_crates: [
        happ_native: [
          path: "native-rust/happ_native"
        ]
      ],

      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),

      dialyzer: [
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"},
        # plt_ignore_apps: [:mnesia]
      ],

      # Docs
      name: "Happ",
      source_url: "https://github.com/korczis/happ",
      homepage_url: "https://github.com/korczis/happ",
      docs: [
        main: "Happ", # The main page in the docs
        logo: "logo.png",
        extras: ["README.md"]
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Happ.Application, []},
      extra_applications: [
        :crypto,
        :eex,
        :hackney,
        :httpoison,
        :logger,
        :runtime_tools,
        :os_mon,
        :toml
      ]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:distillery, "~> 2.1"},
      {:phoenix, "~> 1.5.8"},
      {:phoenix_ecto, "~> 4.1"},
      {:ecto_sql, "~> 3.4"},
      {:ecto_psql_extras, "~> 0.2"},
      {:elasticsearch, "~> 1.0.0"},
      {:ex_doc, "~> 0.24.2"},
      {:floki, "~> 0.30.0"},
      {:hackney, "~> 1.17"},
      {:html5ever, "~> 0.8.0"},
      {:httpoison, "~> 1.8"},
      {:horde, "~> 0.8.3"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_dashboard, "~> 0.4"},
      {:telemetry_metrics, "~> 0.4"},
      {:telemetry_poller, "~> 0.4"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:poison, "~> 3.1"},
      {:rustler, "~> 0.21.1"},
      {:uuid, "~> 1.1"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "cmd npm install --prefix assets"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test --trace --cover"] ## --stale
    ]
  end
end
