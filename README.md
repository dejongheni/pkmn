# Pkmn

Homework for Fabernovel

Elixir, Erlang, Node.js and PostgreSQL are required, note on installation here: https://hexdocs.pm/phoenix/installation.html

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Populate database with `mix run priv/repo/seeds_stats.exs && mix run priv/repo/seeds_pkmn.exs`
  * Install Node.js dependencies with `cd assets && npm install`
  * Install react-phoenix node dependencies to temporary solve https://github.com/geolessel/react-phoenix/issues/39 :
    * `mv react-phoenix.package.json deps/react_phoenix/package.json`
    * `cd deps/react_phoenix/ && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

