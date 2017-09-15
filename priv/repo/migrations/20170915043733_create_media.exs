defmodule Ahfi.Repo.Migrations.CreateMedia do
  use Ecto.Migration

  def change do
    create table(:media) do
      add :filename, :string

      timestamps()
    end

  end
end
