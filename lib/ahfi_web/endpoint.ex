defmodule AhfiWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :ahfi

  @files_path Application.get_env(:ahfi, :files_path)
  
  socket "/socket", AhfiWeb.UserSocket

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phoenix.digest
  # when deploying your static files in production.

  plug Plug.Static,
    at: "/media/", from: @files_path, gzip: false

  plug Plug.Static,
    at: "/static/", from: :ahfi, gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt apps media)

  plug Plug.Static,
    at: "/", from: :ahfi, gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt apps media vendor)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  plug Plug.Session,
    store: :cookie,
    key: "_ahfi_key",
    signing_salt: "Lpg7E2KS"

  plug AhfiWeb.Router
end
