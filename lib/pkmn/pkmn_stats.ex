defmodule Pkmn.Pkmn_stats do
  alias Pkmn.Repo
  alias Pkmn.Stat
  alias Pkmn.Pokemon

  def get_stats_by(params) do
    case Repo.get_by(Stat, params) do
      nil -> {:error, "not found"}
      stats -> {:ok, stats}
    end
  end

  def get_pkmn(params) do
    case Repo.get_by(Pokemon, params) do
      nil -> {:error, "not found"}
      pkmn -> {:ok, pkmn}
    end
  end

  def get_likes_dislikes_by(params) do
    case Repo.get_by(Pokemon, params) do
      %{likes: likes, dislikes: dislikes} ->
            {:ok, %{likes: if is_nil(likes) do 0 else likes end,
              dislikes: if is_nil(dislikes) do 0 else dislikes end}}
      nil -> {:error, "not found"}
    end

  end


  def add_like(params) do
    case Repo.get_by(Pokemon, params) do
      nil -> {:error, "not found"}
      pokemon ->
        pkmn =
          Ecto.Changeset.change(
            pokemon,
            likes: if is_nil(pokemon.likes) do 1 else pokemon.likes+1 end
          )|> Repo.update!()
        {:ok, pkmn}
    end
  end

  def add_dislike(params) do
    case Repo.get_by(Pokemon, params) do
      nil -> {:error, "not found"}
      pokemon ->
        pkmn =
          Ecto.Changeset.change(
            pokemon,
            dislikes: if is_nil(pokemon.dislikes) do 1 else pokemon.dislikes+1 end
          )|> Repo.update!
        {:ok, pkmn}
    end
  end
end
