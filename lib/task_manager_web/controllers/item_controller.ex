defmodule TaskManagerWeb.ItemController do
  use TaskManagerWeb, :controller

  import Ecto.Query

  alias TaskManager.Repo
  alias TaskManager.Todo
  alias TaskManager.Todo.Item

  @doc """
  """
  def clear_completed(conn, _param) do
    person_id = 0
    query = from(i in Item, where: i.person_id == ^person_id, where: i.status == 1)
    Repo.update_all(query, set: [status: 2])
    index(conn, %{filter: "all"})
  end

  @doc """
  """
  def index(conn, params) do
    item =
      if not is_nil(params) and Map.has_key?(params, "id") do
      Todo.get_item!(params["id"])
    else
      %Item{}
    end

    items = Todo.list_items()
    changeset = Todo.change_item(item)

    render(conn, "index.html",
      items: items,
      changeset: changeset,
      editing: item,
      filter: Map.get(params, "filter", "all")
    )
  end

  @doc """
  """
  def new(conn, _params) do
    changeset = Todo.change_item(%Item{})
    render(conn, "new.html", changeset: changeset)
  end

  @doc """
  """
  def create(conn, %{"item" => item_params}) do
    case Todo.create_item(item_params) do
      {:ok, item} ->
        conn
        |> put_flash(:info, "Item created successfully.")
        |> redirect(to: Routes.item_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  @doc """
  """
  def show(conn, %{"id" => id}) do
    item = Todo.get_item!(id)
    render(conn, "show.html", item: item)
  end

  @doc """
  """
  def edit(conn, params) do
    index(conn, params)
  end

  @doc """
  """
  def update(conn, %{"id" => id, "item" => item_params}) do
    item = Todo.get_item!(id)

    case Todo.update_item(item, item_params) do
      {:ok, item} ->
        conn
        |> put_flash(:info, "Item updated successfully.")
        |> redirect(to: Routes.item_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", item: item, changeset: changeset)
    end
  end

  @doc """
  """
  def delete(conn, %{"id" => id}) do
    item = Todo.get_item!(id)
    {:ok, _item} = Todo.delete_item(item)

    conn
    |> put_flash(:info, "Item deleted successfully.")
    |> redirect(to: Routes.item_path(conn, :index))
  end

  @doc """
  """
  def toggle(conn, %{"id" => id}) do
    item = Todo.get_item!(id)
    Todo.update_item(item, %{status: toggle_status(item)})
    redirect(conn, to: Routes.item_path(conn, :index))
  end

  @doc """
  """
  def toggle_status(item) do
    case item.status do
      0 -> 1
      1 -> 0
    end
  end
end
