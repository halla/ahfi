defmodule AhfiWeb.Router do
  use Ahfi.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Ahfi.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AhfiWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/projects/", PageController, :projects
    get "/coaching/", PageController, :coaching
    get "/consulting/", PageController, :consulting
    post "/contact", PageController, :contact
    get "/blog/", PageController, :blog
    get "/blog/feeds/rss/", PostController, :rss
    get "/blog/:year/:month/:slug/", PostController, :view

    resources "/posts", PostController
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Ahfi do
  #   pipe_through :api
  # end
end
