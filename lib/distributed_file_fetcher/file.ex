defmodule DistributedFileFetcher.File do
  @moduledoc """
  Utility module to fetch files and store them.
  """

  require Logger

  alias DistributedFileFetcher.ExchangeRate

  @doc """
  Fetches the file from the url and stores it in the destination path.
  """
  @spec store_file({String.t(), String.t()}, String.t()) :: {:ok, String.t()}
  def store_file({source, file}, destination_path) do
    destination = destination_path <> "/#{source}.json"

    File.cp!(file, destination)
    Logger.info("Storing #{source} in #{destination}")

    {:ok, destination}
  end

  @doc """
  Processes the file and stores the data in the database.
  """
  @spec process(String.t(), String.t()) :: [map]
  def process(file, source) do
    exchange_rates = ExchangeRate.get_exchange_rates_map()

    data =
      file
      |> File.read!()
      |> Jason.decode!()
      |> Map.get("data")

    Enum.map(data, fn record ->
      exchange_rate = Map.get(exchange_rates, record["currency"])
      revenue_in_usd = record["revenue"] * exchange_rate

      record
      |> Map.put("revenue_in_usd", revenue_in_usd)
      |> Map.put("source", source)
    end)
  end
end
