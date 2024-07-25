defmodule DistributedFileFetcher.Repo.Migrations.AddFileDataTable do
  use Ecto.Migration

  def change do
    create table(:file_data) do
      add :source, :text
      add :date, :date
      add :currency, :string
      add :revenue, :float
      add :revenue_in_usd, :float
      add :key, :text
      add :key2, :text
      add :key3, :text
      add :key4, :text
      add :key5, :text
      add :key6, :text
      add :key7, :text
      add :key8, :text
      add :key9, :text
      add :key10, :text

      timestamps()
    end
  end
end
