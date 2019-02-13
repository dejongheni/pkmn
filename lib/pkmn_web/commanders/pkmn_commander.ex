defmodule PkmnWeb.PkmnCommander do

  use Drab.Commander
  import Pkmn.Pkmn_stats

  defhandler add_like(socket, _sender) do
    {:ok, pokemon} = Drab.Live.peek(socket, :pokemon)
    %{likes: likes} = add_like(name: pokemon["species"]["name"])
    Drab.Live.poke socket, likes_number: likes
  end

  defhandler add_dislike(socket, _sender) do
    {:ok, pokemon} = Drab.Live.peek(socket, :pokemon)
    %{dislikes: dislikes} = add_dislike(name: pokemon["species"]["name"])
    Drab.Live.poke socket, dislikes_number: dislikes
  end
end
