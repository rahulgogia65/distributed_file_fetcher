defmodule DistributedFileFetcher.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: DistributedFileFetcher.Worker.start_link(arg)
      # {DistributedFileFetcher.Worker, arg}
      DistributedFileFetcher.Repo,
      {Oban, Application.fetch_env!(:distributed_file_fetcher, Oban)},
      {Cluster.Supervisor, [topologies(), [name: DistributedFileFetcher.ClusterSupervisor]]},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DistributedFileFetcher.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp topologies, do: Application.fetch_env!(:libcluster, :topologies)
end
