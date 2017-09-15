defmodule AhfiWeb.MediaView do
  use Ahfi.Web, :view


  @files_path Application.get_env(:ahfi, :files_path)
  def render_media(media) do
    """
    <img src="#{"/" <> @files_path <> media.filename}" />
    """
  end
end
