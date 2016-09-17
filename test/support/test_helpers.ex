defmodule Ahfi.TestHelpers do
  alias Ahfi.Post
  alias Ahfi.Repo

  def insert_post(attrs \\ %{}) do
      %Post{}
       |> Post.changeset(attrs)
       |> Repo.insert!()
  end
end
