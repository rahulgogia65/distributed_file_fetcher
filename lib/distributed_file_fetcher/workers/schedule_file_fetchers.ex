defmodule DistributedFileFetcher.Workers.ScheduleFileFetchers do
  @moduledoc """
  Worker to schedule the file fetchers.
  """

  use Oban.Worker,
    queue: :fetch,
    max_attempts: 3

  @urls for i <- 1..10,
            do:
              {"file#{i}",
              Path.expand("../../../files_source/file#{i}.json", __DIR__)}

  @doc """
  Schedules the file fetchers.
  """
  @impl Oban.Worker
  def perform(%Oban.Job{}) do
    Enum.map(@urls, fn {source, url} ->
      DistributedFileFetcher.Workers.FetchFile.new(%{source: source, url: url}) |> Oban.insert!()
    end)
    :ok
  end
end
