defmodule Ahfi.Repo.Migrations.AddPublishedFlag do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :is_published, :boolean, default: false
    end
  end
end
