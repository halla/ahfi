defmodule AhfiWeb.SessionController do
  use Ahfi.Web, :controller

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{ "session" => %{ "password" => password }}) do
    case AhfiWeb.Auth.login_with_password(conn, password) do
      {:ok, conn} ->
        conn
          |> put_flash(:info, "Login succesful.")
          |> redirect(to: page_path(conn, :index))
      {:error, _reason, conn} ->
        conn
          |> put_flash(:error, "Error logging in")
          |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
      |> AhfiWeb.Auth.logout()
      |> put_flash(:info, "Logged out.")
      |> redirect(to: page_path(conn, :index))
  end
end
