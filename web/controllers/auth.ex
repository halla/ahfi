defmodule Ahfi.Auth do
  import Plug.Conn
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]
  import Phoenix.Controller
  alias Ahfi.Router.Helpers

  def init(_opts) do

  end

  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)
    assign(conn, :current_user, user_id != nil)
  end

  def authenticate_user(conn, opts) do
      if conn.assigns.current_user do
        conn
      else
        conn
          |> put_flash(:error, "Need to be logged in.")
          |> redirect(to: Helpers.page_path(conn, :index))
          |> halt()
      end
  end

  def login(conn) do
    conn
     |> assign(:current_user, true)
     |> put_session(:user_id, 1)
     |> configure_session(renew: true)
  end

  def login_with_password(conn, given_password) do
    if checkpw(given_password,Application.get_env(:ahfi, :password_hash)) do
      { :ok, login(conn) }
    else
      { :error, :unauthorized, conn }
    end
  end

  def logout(conn) do
      configure_session(conn, drop: true)
  end
end
