defmodule Ahfi.PostControllerTest do
  use Ahfi.ConnCase

  alias Ahfi.Post
  @valid_attrs %{body: "some content", date_published: %{day: 17, month: 4, year: 2010}, slug: "some content", title: "some content", is_published: true}
  @invalid_attrs %{}


  setup %{conn: conn} = config do
    if config[:login_as] do
      conn = assign(conn, :current_user, true)
      {:ok, conn: conn}
    else
      :ok
    end

  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, post_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing posts"
  end

  @tag login_as: "somebody"
  test "renders form for new resources", %{conn: conn} do
    conn = get conn, post_path(conn, :new)
    assert html_response(conn, 200) =~ "New post"
  end


  test "modifications are forbidden from the unauthenticated", %{conn: conn} do
      conn = post conn, post_path(conn, :create), post: @valid_attrs
      assert html_response(conn, 302)
      assert conn.halted
  end

  @tag login_as: "somebody"
  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, post_path(conn, :create), post: @valid_attrs
    assert redirected_to(conn) == post_path(conn, :index)
    assert Repo.get_by(Post, @valid_attrs)
  end

  @tag login_as: "somebody"
  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, post_path(conn, :create), post: @invalid_attrs
    assert html_response(conn, 200) =~ "New post"
  end

  test "shows chosen resource", %{conn: conn} do
    post = insert_post(@valid_attrs)

    conn = get conn, post_path(conn, :show, post)
    assert html_response(conn, 200) =~ post.title
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, post_path(conn, :show, -1)
    end
  end

  @tag login_as: "somebody"
  test "renders form for editing chosen resource", %{conn: conn} do
    post = Repo.insert! %Post{}
    conn = get conn, post_path(conn, :edit, post)
    assert html_response(conn, 200) =~ "Edit post"
  end

  @tag login_as: "somebody"
  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    post = Repo.insert! %Post{}
    conn = put conn, post_path(conn, :update, post), post: @valid_attrs
    assert redirected_to(conn) == post_path(conn, :show, post)
    assert Repo.get_by(Post, @valid_attrs)
  end

  @tag login_as: "somebody"
  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    post = Repo.insert! %Post{}
    conn = put conn, post_path(conn, :update, post), post: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit post"
  end

  @tag login_as: "somebody"
  test "deletes chosen resource", %{conn: conn} do
    post = Repo.insert! %Post{}
    conn = delete conn, post_path(conn, :delete, post)
    assert redirected_to(conn) == post_path(conn, :index)
    refute Repo.get(Post, post.id)
  end

  @tag login_as: "somebody"
  test "unpublished shown if logged in", %{conn: conn} do
    attrs = Dict.merge(@valid_attrs, %{is_published: false})
    post = insert_post(attrs)
    conn = get conn, post_path(conn, :show, post)
    assert html_response(conn, 200) =~ post.title
  end

  test "unpublished not shown if not logged in", %{conn: conn} do
    attrs = Dict.merge(@valid_attrs, %{is_published: false})
    post = insert_post(attrs)
    conn = get conn, post_path(conn, :show, post)
    assert html_response(conn, 404)
  end

  test "unpublished not listed in rss if not logged in", %{conn: conn} do
    attrs = Dict.merge(@valid_attrs, %{is_published: true})
    post = insert_post(attrs)
    conn = get conn, post_path(conn, :rss)
    assert length(conn.assigns.posts) == 0
  end

  test "published listed in rss if not logged in", %{conn: conn} do
    attrs = Dict.merge(@valid_attrs, %{is_published: true})
    post = insert_post(attrs)
    conn = get conn, post_path(conn, :rss)
    assert length(conn.assigns.posts) == 1
  end

end
