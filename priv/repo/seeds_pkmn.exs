# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds_pkmn.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Pkmn.Repo.insert!(%Pkmn.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Pkmn.Repo
alias Pkmn.Pokemon

{:ok, %HTTPoison.Response{status_code: 200, body: body}} =
    HTTPoison.get(Application.get_env(:pkmn, :pokeapi_url) <> "pokedex/1")

{:ok, list_of_pkmns} =
  body
  |> Poison.decode!
  |> Map.fetch("pokemon_entries")

for pkmn <- list_of_pkmns do
  Repo.insert(
    %Pokemon{
      pokemon_id: pkmn["entry_number"],
      name: pkmn["pokemon_species"]["name"]
    })
end
