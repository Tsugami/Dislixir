defmodule Dislixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :dislixir,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      # Isso faz com que o mix run funcione.

      mod: {Dislixir.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Uma dependencia de json para nossa aplicação. para codificar e decodificar.
      {:credo, "~> 1.4", only: [:dev, :test], runtime: false},
      {:poison, "~> 3.1"},
      {:httpoison, "~> 1.6"},
      {:gen_stage, "~> 1.0.0"},
      {:gun, "~> 1.3"}
    ]
  end
end
