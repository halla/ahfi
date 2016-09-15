defmodule Ahfi.LayoutView do
  use Ahfi.Web, :view

  def gtmcode() do
    Application.get_env(:ahfi, :gtm)[:id]
  end

end
