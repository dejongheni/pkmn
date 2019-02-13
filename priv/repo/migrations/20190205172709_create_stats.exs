defmodule Pkmn.Repo.Migrations.CreateStats do
  use Ecto.Migration

  def change do
    create table(:stats) do
      add :type, :string, null: false

      add :speed, :integer, null: false
      add :specialdefense, :integer, null: false
      add :specialattack, :integer, null: false
      add :defense, :integer, null: false
      add :attack, :integer, null: false
      add :hp, :integer, null: false
    end

    create unique_index(:stats, [:type])
  end
end
