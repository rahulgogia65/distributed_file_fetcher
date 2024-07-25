defmodule DistributedFileFetcher.File.Data do
  @moduledoc """
  This module defines the schema for the file_data table.

  There are other utility functions defined in this module to insert data into the table.
  """

  use Ecto.Schema

  alias __MODULE__
  alias DistributedFileFetcher.Utils
  alias Ecto.Changeset

  @required_attrs [:source, :date, :currency, :revenue, :revenue_in_usd]

  @attrs [:key, :key2, :key3, :key4, :key5, :key6, :key7, :key8, :key9, :key10 | @required_attrs]

  ## Types

  @type t :: %__MODULE__{}

  ## Schema Definition

  schema "file_data" do
    field :source, :string
    field :date, :date
    field :currency, :string
    field :revenue, :float
    field :revenue_in_usd, :float
    field :key, :string
    field :key2, :string
    field :key3, :string
    field :key4, :string
    field :key5, :string
    field :key6, :string
    field :key7, :string
    field :key8, :string
    field :key9, :string
    field :key10, :string

    timestamps()
  end

  ## Changeset

  @doc """
  Casts and validates the data schema.
  """
  @spec changeset(t, map) :: Changeset.t()
  def changeset(%Data{} = data, attrs) do
    data
    |> Changeset.cast(attrs, @attrs)
    |> Changeset.validate_required(@required_attrs)
  end

  ## Repo Functions

  @doc """
  Inserts bulk data into the file_data table.
  """
  @spec insert_data([map]) :: {non_neg_integer(), [Data.t()]} | {:error, [Changeset.t()]}
  def insert_data(attrs) when is_list(attrs),
    do: Utils.bulk_insert(Data, attrs, @attrs)
end
