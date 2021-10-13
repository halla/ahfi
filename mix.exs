defmodule Ahfi.Mixfile do
  use Mix.Project

  def project do
    [app: :ahfi,
     version: "0.0.2",
     elixir: "~> 1.4",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Ahfi.Application, []},
     applications: [:phoenix, :phoenix_pubsub, :phoenix_html, :cowboy, :logger, :gettext,
                    :phoenix_ecto, :postgrex, :timex, :comeonin, :earmark, :swoosh, :gen_smtp, :plug_cowboy ]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.4"},
     {:phoenix_pubsub, "~> 1.0"},
     {:phoenix_ecto, "~> 3.2"},
     {:bcrypt_elixir, "~> 1.0"},
     {:plug_cowboy, "~> 2.0"},
     {:plug, "~> 1.7"},
     {:postgrex, ">= 0.0.0"},
     {:phoenix_html, "~> 2.6"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:gettext, "~> 0.11"},
  #   { :earmark, "~> 1.2" },
     {:earmark, git: "https://github.com/ypisetsky/earmark"}, # temp fix, pr pending
     {:timex, "~> 3.1"},
     {:httpoison, "~> 0.13"},
     {:poison, "~> 3.1"},
     {:comeonin, "~> 4.0"},
     {:distillery, "~> 1.0"},
     {:swoosh, "~> 1.5"},
     {:gen_smtp, "~> 1.1.0"}]

  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
