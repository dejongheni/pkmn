defmodule Pkmn.Repo.Migrations.AddLikeDislikesToPkmn do
  use Ecto.Migration

  def change do
    alter table(:pokemons) do
      add :likes, :integer
      add :dislikes, :integer
    end
  end
end
