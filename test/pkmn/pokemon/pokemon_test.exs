defmodule Pkmn.PkmnTest do
  use Pkmn.DataCase
  alias Pkmn.Pokemon
  alias Pkmn.Stat

  describe "get_stats_by/1" do
    setup do
      {:ok, stat: stat_fixture(type: "test stat")}
    end

    test "return stat on type: test stat" do
      assert {:ok, %Stat{type: "test stat"}} = Pkmn.Pkmn_stats.get_stats_by(type: "test stat")
    end

    test "return Ecto.NoResultsError on type: test" do
      assert {:error, "not found"} = Pkmn.Pkmn_stats.get_stats_by(type: "test")
    end
  end

  describe "get_likes_dislikes_by/1" do
    setup do
      {:ok, pokemon: pkmn_fixture(name: "toto", likes: 7, dislikes: 8)}
    end

    test "return %{likes: 7, dislike: 8} on name: toto" do
      assert {:ok, %{likes: 7, dislikes: 8}} = Pkmn.Pkmn_stats.get_likes_dislikes_by(name: "toto")
    end

    test "return not found on name: tata" do
      assert {:error, "not found"} = Pkmn.Pkmn_stats.get_likes_dislikes_by(name: "tata")
    end
  end

  describe "add_like/1" do
    setup do
      {:ok, pokemon: pkmn_fixture(name: "toto", likes: 0, dislikes: 0)}
    end

    test "return %Pokemon{likes: 1, dislikes: 0} on name: toto" do
      assert {:ok, %Pokemon{likes: 1, dislikes: 0}} = Pkmn.Pkmn_stats.add_like(name: "toto")
    end

    test "assert not found on name: tata" do
      assert {:error, "not found"} = Pkmn.Pkmn_stats.add_like(name: "tata")
    end
  end

  describe "add_dislike/1" do
    setup do
      {:ok, pokemon: pkmn_fixture(name: "toto", likes: 0, dislikes: 0)}
    end

    test "return %Pokemon{likes: 0, dislikes: 1} on name: toto" do
      assert {:ok, %Pokemon{likes: 0, dislikes: 1}} = Pkmn.Pkmn_stats.add_dislike(name: "toto")
    end

    test "assert not found on name: tata" do
      assert {:error, "not found"} = Pkmn.Pkmn_stats.add_dislike(name: "tata")
    end
  end

  describe "get_pkmn/1" do
    setup do
      {:ok, pokemon: pkmn_fixture(name: "toto", likes: 0, dislikes: 0)}
    end

    test "return %Pokemon{} on name: toto" do
      assert {:ok, %Pokemon{}} = Pkmn.Pkmn_stats.get_pkmn(name: "toto")
    end

    test "return nil on name tata" do
      assert {:error, "not found"} == Pkmn.Pkmn_stats.get_pkmn(name: "tata")
    end
  end
end
