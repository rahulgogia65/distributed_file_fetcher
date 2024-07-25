defmodule DistributedFileFetcher.Repo.Migrations.AddExchangeRatesTable do
  use Ecto.Migration

  def change do
    create table(:exchange_rates) do
      add :currency, :string
      add :rate, :float
    end
  end
end
