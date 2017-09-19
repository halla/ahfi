defmodule Ahfi.CMS do
  @moduledoc """
  The CMS context.
  """

  import Ecto.Query, warn: false
  alias Ahfi.Repo

  alias Ahfi.CMS.Media
  alias Ahfi.Post

  @doc """
  Returns the list of media.

  ## Examples

      iex> list_media()
      [%Media{}, ...]

  """
  def list_media do
    Repo.all(Media)
  end

  @doc """
  Gets a single media.

  Raises `Ecto.NoResultsError` if the Media does not exist.

  ## Examples

      iex> get_media!(123)
      %Media{}

      iex> get_media!(456)
      ** (Ecto.NoResultsError)

  """
  def get_media!(id), do: Repo.get!(Media, id)

  @doc """
  Creates a media.

  ## Examples

      iex> create_media(%{field: value})
      {:ok, %Media{}}

      iex> create_media(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @files_path Application.get_env(:ahfi, :files_path, "/tmp/")
  def create_media(attrs \\ %{}) do
    file = attrs["file"]

    with %{filename: filename, path: path} = file,
         :ok = File.cp(path, @files_path <> filename )
    do
      attrs = Map.put(attrs, "filename", filename)
      %Media{}
      |> Media.changeset(attrs)
      |> Repo.insert()
    end

  end

  @doc """
  Updates a media.

  ## Examples

      iex> update_media(media, %{field: new_value})
      {:ok, %Media{}}

      iex> update_media(media, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_media(%Media{} = media, attrs) do
    media
    |> Media.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Media.

  ## Examples

      iex> delete_media(media)
      {:ok, %Media{}}

      iex> delete_media(media)
      {:error, %Ecto.Changeset{}}

  """
  def delete_media(%Media{} = media) do
    Repo.delete(media)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking media changes.

  ## Examples

      iex> change_media(media)
      %Ecto.Changeset{source: %Media{}}

  """
  def change_media(%Media{} = media) do
    Media.changeset(media, %{})
  end



  def list_posts_for_user(user) do
    query = if user do
      from p in Post,
      order_by: [desc: p.date_published]
    else
      from p in Post,
      where: p.is_published == true,
      order_by: [desc: p.date_published]
    end
    Repo.all(query)
  end
end
