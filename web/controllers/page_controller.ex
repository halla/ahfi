defmodule Ahfi.PageController do
  use Ahfi.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end


  def projects(conn, _params) do
    render conn, "projects.html",  metaTitle: "Projects"
  end

  def blog(conn, _params) do
    posts = Repo.all(from p in Ahfi.PostController.myVisiblePosts(conn), order_by: [desc: p.date_published])
    render conn, "blog.html", posts: posts, metaTitle: "Blog"
  end
end
