defmodule PkmnWeb.PkmnView do
  use PkmnWeb, :view


  def stat_of_pkmn(pkmn) do
    %{
      speed: Enum.at(pkmn["stats"], 0)["base_stat"],
      specialdefense: Enum.at(pkmn["stats"], 1)["base_stat"],
      specialattack: Enum.at(pkmn["stats"], 2 |> Kernel.trunc)["base_stat"],
      defense: Enum.at(pkmn["stats"], 3)["base_stat"],
      attack: Enum.at(pkmn["stats"], 4)["base_stat"],
      hp: Enum.at(pkmn["stats"], 5)["base_stat"]
    }
  end


  def get_sprite(pkmn_url) do
    case HTTPoison.get(pkmn_url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Poison.decode! body
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        "Pokemon not found"
      {:error, %HTTPoison.Error{reason: reason}} ->
        reason
    end
    |> Map.fetch!("sprites")
    |> Map.fetch!("front_default")
  end
end
