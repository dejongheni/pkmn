defmodule Pkmn.Stat do
  use Ecto.Schema

  schema "stats" do
    field :type, :string

    field :speed, :integer
    field :specialdefense, :integer
    field :specialattack, :integer
    field :defense, :integer
    field :attack, :integer
    field :hp, :integer

  end

end
