defmodule Raffley.MixProject do
  use Mix.Project

  def project do
    [
      app: :raffley,
      version: "0.1.0",
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Raffley.Application, []},
      extra_applications: [:logger, :runtime_tools]
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
      {:phoenix, "== 1.7.19"},
      {:phoenix_ecto, "== 4.6.3"},
      {:ecto_sql, "== 3.12.1"},
      {:postgrex, "== 0.20.0"},
      {:myxql, "== 0.7.1"},
      {:phoenix_html, "== 4.2.0"},
      {:phoenix_live_reload, "== 1.5.3", only: :dev},
      {:phoenix_live_view, "== 1.0.4"},
      {:floki, "== 0.37.0", only: :test},
      {:phoenix_live_dashboard, "== 0.8.6"},
      {:esbuild, "== 0.9.0", runtime: Mix.env() == :dev},
      {:tailwind, "== 0.2.4", runtime: Mix.env() == :dev},
      {:heroicons, path: "deps/heroicons", app: false, compile: false},
      {:swoosh, "== 1.17.10"},
      {:finch, "== 0.19.0"},
      {:telemetry_metrics, "== 1.1.0"},
      {:telemetry_poller, "== 1.1.0"},
      {:gettext, "== 0.26.2"},
      {:jason, "== 1.4.4"},
      {:dns_cluster, "== 0.1.3"},
      {:bandit, "== 1.6.7"},
      {:ex_phone_number, "== 0.4.5"},
      {:timex, "== 3.7.11"},
      {:number, "== 1.0.5"},
      {:pbkdf2_elixir, "== 2.3.1"},
      {:logger_file_backend, "== 0.0.14"}
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
      setup: ["deps.get", "ecto.setup", "assets.setup", "assets.build"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.setup": ["tailwind.install --if-missing", "esbuild.install --if-missing"],
      "assets.build": ["tailwind raffley", "esbuild raffley"],
      "assets.deploy": [
        "tailwind raffley --minify",
        "esbuild raffley --minify",
        "phx.digest"
      ]
    ]
  end
end
