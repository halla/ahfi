defmodule Ahfi.Repo.Migrations.CreateContactMsg do
  use Ecto.Migration

  def change do
    create table(:contact_msgs) do
      add :email, :string
      add :name, :string
      add :body, :text

      timestamps()
    end
  end
end
