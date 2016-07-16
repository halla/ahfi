defmodule Ahfi.PostView do
  use Ahfi.Web, :view


  def year(post) do
    post.date_published.year
  end

  def month(%Ahfi.Post{date_published: date_published} = post) do
    month(date_published)

  end

  def month(date) do
    String.pad_leading(to_string(date.month), 2, "0")
  end

  def format_date(date) do
    "#{date.year}-#{month(date)}-#{date.day}"
  end

  def disqus_shortname do
    Application.get_env(:ahfi_ex, :disqus)[:shortname]
  end

  def absolute_url(conn, post) do
    yearmonth = "#{year(post)}/#{month(post)}/"

    (to_string conn.scheme) <> "://" <> conn.host <> "/blog/" <> yearmonth <> post.slug <> "/"
  end

  def rss_date(datetime) do
    to_string(datetime)
    #  Timex.format(datetime, "{RFC822}")

  end

end
