defmodule Pkmn.Repo.Migrations.CreatePokemons do
  use Ecto.Migration

  def change do
    create table(:pokemons) do
      add :pokemon_id, :integer, null: false
      add :name, :string, null: false
    end

    create unique_index(:pokemons, [:pokemon_id, :name])
  end
end
