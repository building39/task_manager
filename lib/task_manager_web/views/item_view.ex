defmodule TaskManagerWeb.ItemView do
  use TaskManagerWeb, :view

  # add class "completed" to a list item if item.status=1
  def complete(item) do
    case item.status do
      1 -> "completed"
      _ -> "" # empty string means empty class so no style applied
    end
  end

  # add "checked" to input if item.status=1
  def checked(item) do
    case item.status do
      1 -> "checked"
      _ -> "" # empty string means empty class so no style applied
    end
  end

  # returns integer value of items where item.status == 0 (not "done")
  def remaining_items(items) do
    Enum.filter(items, fn i -> i.status == 0 end) |> Enum.count
  end

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

  def selected(filter, str) do
    case filter == str do
      true -> "selected"
      false -> ""
    end
  end
        
end
