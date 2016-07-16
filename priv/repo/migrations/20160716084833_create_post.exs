defmodule Ahfi.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :body, :text
      add :slug, :string
      add :date_published, :date
      add :title, :string

      timestamps()
    end

  end
end
