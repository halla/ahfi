defmodule Ahfi.PageController do
  use Ahfi.Web, :controller

  def index(conn, _params) do
    posts = Repo.all(from p in Ahfi.Post, order_by: [desc: p.date_published])

    render conn, "index.html", posts: posts
  end
end
