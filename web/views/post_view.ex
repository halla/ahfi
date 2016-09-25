defmodule Ahfi.PostView do
  use Ahfi.Web, :view
  use Timex

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
    Application.get_env(:ahfi, :disqus)[:shortname]
  end

  def absolute_url(conn, post) do
    yearmonth = "#{year(post)}/#{month(post)}/"

    site_url_base <> "/blog/" <> yearmonth <> post.slug <> "/"
  end

  def rss_date(date) do
    datetime = Timex.to_datetime({date.year, date.month, date.day})
    #to_string(datetime)
    {:ok, result} = Timex.format(datetime, "{RFC822}")
    result
  end

  def site_url_base() do
    Application.get_env(:ahfi, :site_url_base)
  end

end
