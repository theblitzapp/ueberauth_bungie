defmodule UeberauthBungie.Mixfile do
  use Mix.Project

  @version String.trim(File.read!("VERSION"))
  @url "https://github.com/tiltify/ueberauth_bungie"

  def project do
    [
      app: :ueberauth_bungie,
      version: @version,
      elixir: "~> 1.15.4",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      source_url: @url,
      homepage_url: @url,
      docs: docs(),
      package: package(),
      description: description(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ueberauth, "~> 0.4"},
      {:oauth2, "~> 2.0"},
      {:jason, "~> 1.2"},
      {:credo,
       override: true,
       git: "https://github.com/rrrene/credo",
       ref: "46c5ba5ee070593be0e7ec5c133be7124bdefc9c",
       only: [:dev, :test],
       runtime: false},
      {:exvcr, "~> 0.9.0", only: [:test]},
      {:earmark, ">= 0.0.0", only: :dev},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp docs do
    [extras: ["README.md"]]
  end

  defp description do
    "An Uberauth strategy for Bungie authentication."
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE", "VERSION"],
      maintainers: ["William Volin"],
      licenses: ["Apache 2.0"],
      links: %{GitHub: @url}
    ]
  end

  defp aliases do
    []
  end
end
