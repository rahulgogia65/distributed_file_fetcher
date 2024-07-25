defmodule DistributedFileFetcher.Repo do
  use Ecto.Repo,
    otp_app: :distributed_file_fetcher,
    adapter: Ecto.Adapters.Postgres
end
