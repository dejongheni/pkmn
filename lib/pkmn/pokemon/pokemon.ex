defmodule Pkmn.Pokemon do
  use Ecto.Schema

  schema "pokemons" do
    field :pokemon_id, :integer
    field :name, :string
    field :likes, :integer
    field :dislikes, :integer
  end
end
