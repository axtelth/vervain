defmodule Vervain.MixProject do
  use Mix.Project

  def project do
    [
      app: :vervain,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Vervain, []}
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.8"},
      {:jason, "~> 1.3"}
    ]
  end
end
