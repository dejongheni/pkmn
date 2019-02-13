# script for populating stats table, run as:
#    mix run priv/repo/seeds_stats.exs

alias Pkmn.Repo
alias Pkmn.Stat

{:ok, %HTTPoison.Response{status_code: 200, body: body}} =
    HTTPoison.get(Application.get_env(:pkmn, :pokeapi_url) <> "pokedex/1")

{:ok, list_of_pkmns} =
  body |> Poison.decode!  |> Map.fetch("pokemon_entries")


Enum.reduce(list_of_pkmns, %{}, fn pkmn, type_map ->

  {:ok, %HTTPoison.Response{status_code: 200, body: body}} =
    HTTPoison.get(Application.get_env(:pkmn, :pokeapi_url) <> "pokemon/" <> to_string(pkmn["entry_number"]), [], [timeout: 50_000, recv_timeout: 50_000])
  {:ok, pkmn} =
    body
    |> Poison.decode

  speed = Enum.at(pkmn["stats"], 0)["base_stat"]
  specialdefense = Enum.at(pkmn["stats"], 1)["base_stat"]
  specialattack = Enum.at(pkmn["stats"], 2 |> Kernel.trunc)["base_stat"]
  defense = Enum.at(pkmn["stats"], 3)["base_stat"]
  attack = Enum.at(pkmn["stats"], 4)["base_stat"]
  hp = Enum.at(pkmn["stats"], 5)["base_stat"]

  Enum.reduce(pkmn["types"], type_map, fn type, type_map ->
    type = type["type"]["name"]
    Map.update(type_map, type,
     %{
      speed: [speed],
      specialdefense: [specialdefense],
      specialattack: [specialattack],
      defense: [defense],
      attack: [attack],
      hp: [hp]
      },
      fn type_stats ->
        %{
          speed: [speed] ++ type_stats.speed,
          specialdefense: [specialdefense] ++ type_stats.specialdefense,
          specialattack: [specialattack] ++ type_stats.specialattack,
          defense: [defense] ++ type_stats.defense,
          attack: [attack] ++ type_stats.attack,
          hp: [hp] ++ type_stats.hp
         }
      end)
  end)
end)
|> Enum.map(fn {type, map_stats} ->
    Repo.insert(
      %Stat{
        type: type,
        speed: Enum.sum(map_stats.speed)/length(map_stats.speed) |> Kernel.trunc,
        specialdefense: Enum.sum(map_stats.specialdefense)/length(map_stats.specialdefense) |> Kernel.trunc,
        specialattack: Enum.sum(map_stats.specialattack)/length(map_stats.specialattack) |> Kernel.trunc,
        defense: Enum.sum(map_stats.defense)/length(map_stats.defense) |> Kernel.trunc,
        attack: Enum.sum(map_stats.attack)/length(map_stats.attack) |> Kernel.trunc,
        hp: Enum.sum(map_stats.hp)/length(map_stats.hp) |> Kernel.trunc
      })
    end)


