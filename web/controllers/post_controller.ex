defmodule Ahfi.PostController do
  use Ahfi.Web, :controller

  alias Ahfi.Post

  def index(conn, _params) do
    posts = Repo.all(Post)
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    changeset = Post.changeset(%Post{}, post_params)

    case Repo.insert(changeset) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: post_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def view(conn, %{"slug" => slug}) do
      post = Repo.get_by!(Post, slug: slug)
      show(conn, %{ "id" => post.id})
  end

  def show(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)
    query = from p in Post,
        where: p.date_published > ^post.date_published,
        order_by: p.date_published,
        limit: 1
    nextPost = Repo.one(query)
    query2 = from p in Post,
        where: p.date_published < ^post.date_published,
        order_by: [desc: p.date_published],
        limit: 1
    prevPost = Repo.one(query2)
    render(conn,
        "show.html",

        post: post,
        metaTitle: post.title,
        metaDescription: String.slice(post.body, 0, 150),
        nextPost: nextPost,
        prevPost: prevPost)
  end


  def edit(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)
    changeset = Post.changeset(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Repo.get!(Post, id)
    changeset = Post.changeset(post, post_params)

    case Repo.update(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: post_path(conn, :show, post))
      {:error, changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: post_path(conn, :index))
  end
end
