defmodule Webapp.Mixfile do
  use Mix.Project

  def project do
    [app: :webapp,
     version: "0.0.1",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Webapp, []},
     applications: [
      :absinthe,
      :absinthe_plug,
      :phoenix,
      :phoenix_pubsub,
      :phoenix_html,
      :cowboy,
      :logger,
      :gettext,
      :httpoison
      ]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:absinthe, "~> 1.2.0"},
      {:absinthe_plug, "~> 1.2.0"},
      {:comeonin, "~> 2.3"},
      {:credo, "~> 0.4", only: [:dev, :test]},
      {:dialyxir, "~> 0.3.5", only: [:dev]},
      {:httpoison, "~> 0.9.2"},
      {:phoenix, "~> 1.2.1", override: true},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_html, "~> 2.6"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:poison, "~> 2.2.0", override: true},
      {:poolboy, "~> 1.5.1", override: true},
      {:gettext, "~> 0.11"},
      {:cowboy, "~> 1.0"}
    ]
  end
end
