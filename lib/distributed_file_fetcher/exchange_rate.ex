defmodule DistributedFileFetcher.ExchangeRate do
  @moduledoc """
  Schema for the exchange rates.
  """

  use Ecto.Schema

  alias __MODULE__
  alias DistributedFileFetcher.Repo
  alias DistributedFileFetcher.Utils
  alias Ecto.Changeset

  @attrs [:currency, :rate]

  ## Types

  @type t :: %__MODULE__{}


  ## Schema Definition

  schema "exchange_rates" do
    field :currency, :string
    field :rate, :float
  end

  ## Changeset

  @spec changeset(t, map) :: Changeset.t()
  def changeset(%__MODULE__{} = exchange_rate, attrs) do
    exchange_rate
    |> Changeset.cast(attrs, @attrs)
    |> Changeset.validate_required(@attrs)
  end

  ## Repo utility functions

  @doc """
  Lists the exchange rates
  """
  @spec list_exchange_rates() :: [t()]
  def list_exchange_rates do
    Repo.all(ExchangeRate)
  end

  @doc """
  Gets the exchange rates as a map
  """
  @spec get_exchange_rates_map() :: %{String.t() => float()}
  def get_exchange_rates_map do
    list_exchange_rates()
    |> Enum.into(%{}, &{&1.currency, &1.rate})
  end

  @doc """
  Inserts the exchange rates
  """
  @spec insert_exchange_rates([map]) :: {non_neg_integer(), [ExchangeRate.t()]} | {:error, [Changeset.t()]}
  def insert_exchange_rates(attrs) when is_list(attrs) do
    Utils.bulk_insert(ExchangeRate, attrs, @attrs)
  end
end
