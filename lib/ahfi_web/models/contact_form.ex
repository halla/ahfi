defmodule Ahfi.ContactForm do
  use Ahfi.Web, :model

  schema "contact_msgs" do
    field :email, :string
    field :name, :string
    field :body, :string

    timestamps()
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ["email", "name", "body"], [])
    |> validate_length(:body, min: 5)
    |> validate_format(:email, ~r/@/)
  end
end
