defmodule Ahfi.Post do
  use Ahfi.Web, :model

  schema "posts" do
    field :body, :string
    field :slug, :string
    field :date_published, Ecto.Date
    field :title, :string
    field :is_published, :boolean
    field :featured_image, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:body, :slug, :date_published, :title, :is_published, :featured_image])
    |> validate_required([:body, :slug, :date_published, :title])
  end
end
