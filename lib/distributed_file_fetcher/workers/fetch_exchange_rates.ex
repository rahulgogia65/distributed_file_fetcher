defmodule DistributedFileFetcher.Workers.FetchExchangeRates do
  @moduledoc """
  Worker to fetch the exchange rates and store them in the database.
  """

  use Oban.Worker,
    queue: :fetch,
    max_attempts: 3

  alias DistributedFileFetcher.ExchangeRate

  @doc """
  Fetches the exchange rates and stores them in the database.
  """
  @impl Oban.Worker
  def perform(_job) do
    # API call here

    response = %{
      "data" => [
        %{"currency" => "INR", "rate" => 0.012},
        %{"currency" => "AED", "rate" => 0.27},
        %{"currency" => "GBP", "rate" => 1.29},
        %{"currency" => "EUR", "rate" => 1..09},
        %{"currency" => "USD", "rate" => 1.0}
      ]
    }

    ExchangeRate.insert_exchange_rates(response["data"])
  end
end
