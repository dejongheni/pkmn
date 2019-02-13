defmodule PkmnWeb.PkmnAPIController do
  use PkmnWeb, :controller
  alias Pkmn.Pkmn_stats

  def get_pkmn(conn, %{"id" => id}) do
     case Pkmn_stats.get_pkmn(id: id) do
      {:error, "not found"} -> conn |> put_status(:not_found) |> render("404.json")
      {:ok, pkmn} -> render(conn, "pkmn.json", pkmn: pkmn)
     end
  end

  def get_pkmn_likes_dislikes(conn, %{"id" => id}) do
    case Pkmn_stats.get_likes_dislikes_by(id: id) do
      {:ok, pkmn} -> render(conn, "likes.json", pkmn: pkmn)
      {:error, "not found"} -> conn |> put_status(:not_found) |> render("404.json")
    end
  end

  def add_pkmn_like(conn, %{"id" => id}) do
    case Pkmn_stats.add_like(id: id) do
      {:ok, pkmn} -> render(conn, "pkmn.json", pkmn: pkmn)
      {:error, "not found"} -> conn |> put_status(:not_found) |> render("404.json")
    end
  end

  def add_pkmn_dislike(conn, %{"id" => id}) do
    case Pkmn_stats.add_dislike(id: id) do
      {:ok, pkmn} -> render(conn, "pkmn.json", pkmn: pkmn)
      {:error, "not found"} -> conn |> put_status(:not_found) |> render("404.json")
    end
  end
end
