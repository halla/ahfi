defmodule AhfiWeb.LayoutView do
  use Ahfi.Web, :view

  def gtmcode() do
    Application.get_env(:ahfi, :gtm)[:id]
  end

  def body_tags(assigns) do
    case assigns[:body_tags] do
      nil -> ""
      tags -> Enum.join(tags, " ")
    end

  end
end
