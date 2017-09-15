defmodule AhfiWeb.MediaController do
  use Ahfi.Web, :controller

  plug :authenticate_user

  alias Ahfi.CMS
  alias Ahfi.CMS.Media


  def index(conn, _params) do
    media = CMS.list_media()
    render(conn, "index.html", media: media)
  end

  def new(conn, _params) do
    changeset = CMS.change_media(%Media{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"media" => media_params}) do
    case CMS.create_media(media_params) do
      {:ok, media} ->
        conn
        |> put_flash(:info, "Media created successfully.")
        |> redirect(to: media_path(conn, :show, media))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    media = CMS.get_media!(id)
    render(conn, "show.html", media: media)
  end

  def edit(conn, %{"id" => id}) do
    media = CMS.get_media!(id)
    changeset = CMS.change_media(media)
    render(conn, "edit.html", media: media, changeset: changeset)
  end

  def update(conn, %{"id" => id, "media" => media_params}) do
    media = CMS.get_media!(id)

    case CMS.update_media(media, media_params) do
      {:ok, media} ->
        conn
        |> put_flash(:info, "Media updated successfully.")
        |> redirect(to: media_path(conn, :show, media))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", media: media, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    media = CMS.get_media!(id)
    {:ok, _media} = CMS.delete_media(media)

    conn
    |> put_flash(:info, "Media deleted successfully.")
    |> redirect(to: media_path(conn, :index))
  end
end
