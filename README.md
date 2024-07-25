# DistributedFileFetcher

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `distributed_file_fetcher` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:distributed_file_fetcher, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/distributed_file_fetcher>.


DistributedFileFetcher.Periodic.FetchFile.new(%{}) |> Oban.insert
DistributedFileFetcher.Workers.ScheduleFileFetchers.new(%{}) |> Oban.insert
