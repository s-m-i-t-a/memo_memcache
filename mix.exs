defmodule MemoMemcache.MixProject do
  use Mix.Project

  def project do
    [
      app: :memo_memcache,
      version: "0.1.0",
      elixir: "~> 1.6",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      description: "A memcache storage for memo library",
      deps: deps(),
      package: package(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      docs: [
        main: "readme",
        extras: [
          "README.md"
        ],
        groups_for_extras: [
          Introduction: ~r/README.md/
        ]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:memcachir, "~> 3.2"},
      {:memo, "~> 1.0"},
      {:ex_doc, "~> 0.19", only: :dev},
      {:credo, "~> 0.9", only: [:dev, :test]},
      {:excoveralls, "~> 0.9", only: :test},
      {:propcheck, "~> 1.1", only: :test}
    ]
  end

  defp package() do
    [
      maintainers: [
        "Jindrich K. Smitka <smitka.j@gmail.com>",
        "Ondrej Tucek <ondrej.tucek@gmail.com>"
      ],
      licenses: ["BSD"],
      links: %{
        "GitHub" => "https://github.com/s-m-i-t-a/memo_memcache"
      }
    ]
  end
end
