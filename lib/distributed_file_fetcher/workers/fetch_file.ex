defmodule DistributedFileFetcher.Workers.FetchFile do
  @moduledoc """
  Worker to fetch the file from the given URL and store it in the local file system.
  """

  use Oban.Worker,
    queue: :fetch,
    max_attempts: 3

  require Logger

  alias DistributedFileFetcher.File
  alias DistributedFileFetcher.Workers.ProcessFile

  @destination_path Path.expand("../../../files_storage/", __DIR__)

  @doc """
  Fetches the file from the given URL and stores it in the local file system.
  """
  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"source" => source, "url" => url}}) do
    {:ok, file} = File.store_file({source, url}, @destination_path)

    %{file: file, source: source}
    |> ProcessFile.new()
    |> Oban.insert!()

    :ok
  end
end
