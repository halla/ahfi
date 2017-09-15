defmodule Ahfi.CMS.Media do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ahfi.CMS.Media


  schema "media" do
    field :filename, :string

    timestamps()
  end

  @doc false
  def changeset(%Media{} = media, attrs) do
    media
    |> cast(attrs, [:filename])
    |> validate_required([:filename])
  end
end
