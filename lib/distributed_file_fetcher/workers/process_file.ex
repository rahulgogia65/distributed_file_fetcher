defmodule DistributedFileFetcher.Workers.ProcessFile do
  @moduledoc """
  Worker to process the file and store the data in the database.
  """

  use Oban.Worker,
    queue: :process,
    max_attempts: 3

  alias DistributedFileFetcher.File
  alias DistributedFileFetcher.File.Data

  @doc """
  Processes the file and stores the data in the database.
  """
  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"file" => file, "source" => source}}) do
    file
    |> File.process(source)
    |> Data.insert_data()
    |> case do
      {count, _} when is_integer(count)-> :ok
      {:error, reason} -> {:error, reason}
    end
  end
end
