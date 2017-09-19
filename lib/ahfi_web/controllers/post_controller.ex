defmodule AhfiWeb.PostController do
  use Ahfi.Web, :controller

  plug :authenticate_user when not (action in [:show, :view, :rss, :index])

  alias Ahfi.Post
  alias Ahfi.CMS

  def myVisiblePosts(conn) do
    user = conn.assigns.current_user
    if user do
      Post
    else
      from p in Post, where: p.is_published == true
    end
  end

  def index(conn, _params) do
    posts = CMS.list_posts_for_user(conn.assigns.current_user)
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{})
    render(conn, "new.html", changeset: changeset, body_tags: ["admin"])
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
    post = Repo.get(myVisiblePosts(conn), id)
    if post do

      query = from p in myVisiblePosts(conn),
          where: p.date_published > ^post.date_published,
          order_by: p.date_published,
          limit: 1
      nextPost = Repo.one(query)
      query2 = from p in myVisiblePosts(conn),
          where: p.date_published < ^post.date_published,
          order_by: [desc: p.date_published],
          limit: 1
      prevPost = Repo.one(query2)
      render(conn,
          "show.html",
          body_tags: ["post"],
          post: post,
          metaTitle: post.title,
          metaDescription: String.slice(post.body, 0, 150),
          nextPost: nextPost,
          prevPost: prevPost)
    else
      conn
      |> put_status(:not_found)
      |> halt()
      #|> redirect(to: page_path(conn, :index))

    end
  end


  def edit(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)
    changeset = Post.changeset(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end


  def update(conn, %{"id" => id, "post" => post_params} = params) do
    post = Repo.get!(Post, id)
    changeset = Post.changeset(post, post_params)

    case Repo.update(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: post_path(conn, :edit, post))
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

  def rss(conn, _params) do
    posts = Repo.all(from p in myVisiblePosts(conn), limit: 10, order_by: [desc: p.date_published] )
    render(conn, "rss.xml", posts: posts)
  end
end
