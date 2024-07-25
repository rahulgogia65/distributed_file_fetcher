import Config

config :distributed_file_fetcher, DistributedFileFetcher.Repo,
  database: "distributed_file_fetcher_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :distributed_file_fetcher, ecto_repos: [DistributedFileFetcher.Repo]

config :distributed_file_fetcher, Oban,
  engine: Oban.Engines.Basic,
  queues: [fetch: 4, process: 4],
  repo: DistributedFileFetcher.Repo

config :distributed_file_fetcher, Oban,
  plugins: [
    {Oban.Plugins.Cron,
     crontab: [
       {"@daily", DistributedFileFetcher.Workers.ScheduleFileFetchers, max_attempts: 3}
     ]}
  ]

config :libcluster,
  topologies: [
    default: [
      strategy: Cluster.Strategy.Gossip
    ]
  ]
