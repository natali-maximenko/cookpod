defmodule CookpodWeb.RecipleController do
  use CookpodWeb, :controller

  alias Cookpod.Catalog
  alias Cookpod.Catalog.Reciple
  alias Cookpod.VisitCounter

  def index(conn, _params) do
    reciples = Catalog.list_reciples()
    render(conn, "index.html", reciples: reciples)
  end

  def new(conn, _params) do
    changeset = Catalog.change_reciple(%Reciple{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"reciple" => reciple_params}) do
    case Catalog.create_reciple(reciple_params) do
      {:ok, reciple} ->
        conn
        |> put_flash(:info, "Reciple created successfully.")
        |> redirect(to: Routes.reciple_path(conn, :show, reciple))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def publish(conn, %{"id" => id}) do
    reciple = Catalog.get_reciple!(id)

    case Catalog.publish_reciple(reciple) do
      {:ok, reciple} ->
        conn
        |> put_flash(:info, "Reciple updated successfully.")
        |> redirect(to: Routes.reciple_path(conn, :show, reciple))
    end
  end

  def statistic(conn, _params) do
    stat = VisitCounter.statistic()
    ids = Map.keys(stat)
    reciples = Catalog.list_reciples_by(ids)
    render(conn, "statistic.html", statistic: stat, reciples: reciples)
  end

  def show(conn, %{"id" => id}) do
    reciple = Catalog.get_reciple!(id)
    total = Catalog.total_reciple_calories(reciple)
    VisitCounter.visit(id)
    render(conn, "show.html", reciple: reciple, total: total)
  end

  def edit(conn, %{"id" => id}) do
    reciple = Catalog.get_reciple!(id)
    changeset = Catalog.change_reciple(reciple)
    render(conn, "edit.html", reciple: reciple, changeset: changeset)
  end

  def update(conn, %{"id" => id, "reciple" => reciple_params}) do
    reciple = Catalog.get_reciple!(id)

    case Catalog.update_reciple(reciple, reciple_params) do
      {:ok, reciple} ->
        conn
        |> put_flash(:info, "Reciple updated successfully.")
        |> redirect(to: Routes.reciple_path(conn, :show, reciple))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", reciple: reciple, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    reciple = Catalog.get_reciple!(id)
    {:ok, _reciple} = Catalog.delete_reciple(reciple)

    conn
    |> put_flash(:info, "Reciple deleted successfully.")
    |> redirect(to: Routes.reciple_path(conn, :index))
  end
end
