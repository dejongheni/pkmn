defmodule PkmnWeb.PkmnAPIView do
  use PkmnWeb, :view

  def render("pkmn.json", %{pkmn: pkmn}) do
    %{
      pokemon_id: pkmn.pokemon_id,
      name: pkmn.name,
      likes: pkmn.likes,
      dislikes: pkmn.dislikes,
    }
  end

  def render("404.json", _assigns) do
    %{error: "not found"}
  end

  def render("likes.json", %{pkmn: pkmn}) do
    pkmn
  end
end
