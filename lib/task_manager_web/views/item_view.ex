defmodule TaskManagerWeb.ItemView do
  use TaskManagerWeb, :view

  @doc """
  Add class "completed" to a list item if item.status=1.
  """
  def complete(item) do
    case item.status do
      1 -> "completed"
      _ -> "" # empty string means empty class so no style applied
    end
  end

  @doc """
  Add "checked" to input if item.status=1.
  """
  def checked(item) do
    case item.status do
      1 -> "checked"
      _ -> "" # empty string means empty class so no style applied
    end
  end

  @doc """
  Returns integer value of items where item.status == 0 (not "done").
  """
  def remaining_items(items) do
    Enum.filter(items, fn i -> i.status == 0 end) |> Enum.count
  end

  @doc """
  Filter items.
  """
  def filter(items, str) do
    case str do
      "all" ->
        Enum.filter(items, fn i -> i.status == 0 || i.status == 1 end)
      "active" ->
        Enum.filter(items, fn i -> i.status == 0 end)
      "completed" ->
        Enum.filter(items, fn i -> i.status == 1 end)
    end
  end

  @doc """
  """
  def selected(filter, str) do
    case filter == str do
      true -> "selected"
      false -> ""
    end
  end
        
  @doc """
  Pluralise the word item when the number of items is greather/less than 1.
  """
  def pluralise(items) do
    case remaining_items(items) == 0 || remaining_items(items) > 1 do
      true -> "items"
      false -> "item"
    end
  end

  @doc """
  Return true if items count is greater than zero.
  """
  def got_items?(items) do
    Enum.filter(items, fn i -> i.status < 2 end) |> Enum.count > 0
  end
end
