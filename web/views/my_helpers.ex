defmodule Ahfi.MyHelpers do
  use Phoenix.HTML

  # http://stackoverflow.com/questions/31572653/apply-css-class-on-element-if-current-page-in-phoenix
  def active_class(conn, path) do
    current_path = Path.join(["/" | conn.path_info])
    if path == current_path do
      "active"
    else
      nil
    end
  end

end
