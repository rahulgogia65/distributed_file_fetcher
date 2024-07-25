defmodule DistributedFileFetcher.Utils do
  @moduledoc """
  Utility functions for the application.
  """

  alias DistributedFileFetcher.Repo

  @doc """
  Bulk insert data into the table.
  """
  @spec bulk_insert(module, [map], [atom]) :: {non_neg_integer(), [struct]} | {:error, [Ecto.Changeset.t()]}
  def bulk_insert(schema_module, attrs_list, attrs) do
    struct = struct(schema_module)
    changesets = Enum.map(attrs_list, &schema_module.changeset(struct, &1))

    {valid_cs, invalid_cs} =
      changesets
      |> Enum.split_with(& &1.valid?)

    if Enum.empty?(invalid_cs) do
      attrs_list = Enum.map(valid_cs, fn cs ->
        cs
        |> Ecto.Changeset.apply_changes()
        |> Map.take(attrs)
        |> Map.put(:inserted_at, {:placeholder, :now})
        |> Map.put(:updated_at, {:placeholder, :now})
      end)

      placeholders = %{now: NaiveDateTime.utc_now(:second)}
      Repo.insert_all(schema_module, attrs_list, placeholders: placeholders)
    else
      {:error, invalid_cs}
    end
  end
end
