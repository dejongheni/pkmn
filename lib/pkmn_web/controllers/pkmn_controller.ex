defmodule PkmnWeb.PkmnController do
  use PkmnWeb, :controller
  import Pkmn.Pkmn_stats

  @get_pkmn "pokemon/"
  @get_pkdex "pokedex/1"

  @doc """
    Take a conn and a map with an id, render the pokemon id page
  """
  def show_pkmn(conn, %{"id" => id}) do
    get_pkmn_url = Application.get_env(:pkmn, :pokeapi_url) <> @get_pkmn <> id
    pokemon =
    case HTTPoison.get(get_pkmn_url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Poison.decode! body
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        conn
        |> put_status(:not_found)
        |> put_view(PkmnWeb.ErrorView)
        |> render("404.html")
      {:error, %HTTPoison.Error{reason: reason}} ->
        reason
    end

    pkmn_species = get_pkmn_species(pokemon)
    stat_of_type = mean_stats_of_pkmn_types(pokemon)
    evolution_chain = get_evolution_chain(pkmn_species)
    {:ok, %{likes: likes_number, dislikes: dislikes_number}} = get_likes_dislikes_by(name: pokemon["species"]["name"])


    render(conn, "show_pkmn.html",
          page_title: pokemon["species"]["name"]
            |> String.capitalize, pokemon: pokemon,
          species: pkmn_species,
          stat_of_type: stat_of_type,
          evolution_chain: evolution_chain,
          likes_number: likes_number,
          dislikes_number: dislikes_number
    )
  end

  defp mean_stats_of_pkmn_types(pkmn) do
    Enum.reduce(pkmn["types"], %{}, fn type, type_map ->
        type = type["type"]["name"]
        {:ok, stats} = get_stats_by(type: type)
        %{
          speed: [stats.speed] ++ Map.get(type_map, "speed", []),
          specialdefense: [stats.specialdefense] ++ Map.get(type_map, "specialdefense", []),
          specialattack: [stats.specialattack] ++ Map.get(type_map, "specialattack", []),
          defense: [stats.defense] ++ Map.get(type_map, "defense", []),
          attack: [stats.attack] ++ Map.get(type_map, "attack", []),
          hp: [stats.hp] ++ Map.get(type_map, "hp", [])
        }
    end)
    |> Enum.map(fn {stat_name, stat_list} ->
      {stat_name, Enum.sum(stat_list)/length(stat_list) |> Kernel.trunc}
    end)
    |> Enum.into(%{})
  end

  defp get_pkmn_species(pkmn) do
    case HTTPoison.get(pkmn["species"]["url"]) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Poison.decode! body
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        "Pokemon not found"
      {:error, %HTTPoison.Error{reason: reason}} ->
        reason
    end
  end

  defp get_evolution_chain(species) do
    case HTTPoison.get(species["evolution_chain"]["url"]) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Poison.decode! body
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        "Pokemon not found"
      {:error, %HTTPoison.Error{reason: reason}} ->
        reason
    end
    |> Map.fetch!("chain")
    |> evolution_chain([])
  end

  defp evolution_chain(%{"species" => species, "evolves_to" => evolves_to}, chain_list) do
    id = species["url"] |> String.split("/", trim: true) |> List.last
    pkmn = %{
      name: species["name"],
      url: Application.get_env(:pkmn, :pokeapi_url) <> @get_pkmn <> id,
      id: id
    }
    evolution_chain(evolves_to |> Enum.at(0), chain_list++[pkmn])
  end

  defp evolution_chain(_, chain_list) do
    chain_list
  end


  def list_pkmn(conn, _params) do
    {:ok, %HTTPoison.Response{status_code: 200, body: body}} =
        HTTPoison.get(Application.get_env(:pkmn, :pokeapi_url) <> @get_pkdex)

    {:ok, list_of_pkmns} =
      body
      |> Poison.decode!
      |> Map.fetch("pokemon_entries")

    render(conn, "list_pkmn.html", list_of_pkmns: list_of_pkmns)
  end
end
