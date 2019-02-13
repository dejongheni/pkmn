defmodule Pkmn.TestHelpers do
  alias Pkmn.Pokemon
  alias Pkmn.Stat
  alias Pkmn.Repo

  def pkmn_fixture(attrs \\ %{}) do
    name = "name#{System.unique_integer([:positive])}"
    id = System.unique_integer([:positive])
    name =
      attrs
      |> Enum.into(%{
        name: name,
        pokemon_id: id,
        likes: 0,
        dislikes: 0
      })

    Repo.insert(%Pokemon{
      name: name.name,
      pokemon_id: name.pokemon_id,
      likes: name.likes,
      dislikes: name.dislikes
    })
  end

  def stat_fixture(attrs \\ %{}) do
    type = "type#{System.unique_integer([:positive])}"

    stat =
      attrs
      |> Enum.into(%{
        type: type,
        speed: 10,
        specialdefense: 10,
        specialattack: 10,
        defense: 10,
        attack: 10,
        hp: 10
      })
    Repo.insert(%Stat{
      type: stat.type,
      speed: stat.speed,
      specialdefense: stat.specialdefense,
      specialattack:  stat.specialattack,
      defense: stat.defense,
      attack: stat.attack,
      hp: stat.hp
    })

  end
end
