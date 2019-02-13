defmodule PkmnWeb.PageController do
  use PkmnWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
