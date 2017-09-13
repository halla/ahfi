defmodule Ahfi.Repo.Migrations.FeaturedImage do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :featured_image, :string
    end
  end
end
