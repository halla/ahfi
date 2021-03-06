defmodule AhfiWeb.PageController do
  use Ahfi.Web, :controller
  alias Ahfi.ContactForm
  alias Ahfi.Repo
  alias Ahfi.CMS

  def index(conn, _params) do
    posts = CMS.get_published_posts(%{limit: 3})
    render conn, "index.html", posts: posts
  end

  def projects(conn, _params) do
    render conn, "projects.html",  metaTitle: "Projects"
  end

  def blog(conn, _params) do
    posts = CMS.list_posts_for_user(conn.assigns.current_user)
    render conn, "blog.html", posts: posts, metaTitle: "Blog"
  end

  def coaching(conn, _params) do
    render conn, "coaching.html"
  end

  def consulting(conn, _params) do
    contact_changeset = ContactForm.changeset(%ContactForm{})
    render conn, "consulting.html", contact_changeset: contact_changeset
  end

  def contact(conn, %{"contact_form" => params}) do
    changeset = ContactForm.changeset(%ContactForm{}, params)
    case Repo.insert(changeset) do
      {:ok, contact_msg} ->
        Task.start(fn ->
          Ahfi.Contact.Email.send(contact_msg)
          |> Ahfi.Notifies.Mailer.deliver
        end)
        Task.start(fn ->
          Ahfi.Notifies.Slack.send!("New contact msg from " <> contact_msg.name)
        end)
        conn
        |> put_flash(:info, "Message sent successfully!")
        |> redirect(to: page_path(conn, :consulting))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Sending message not successful.")
        |> render("consulting.html", contact_changeset: changeset)
    end

  end
end
