defmodule UeberauthBungie do
  @moduledoc false

  def refresh_token(refresh_token) do
    Ueberauth.Strategy.Bungie.OAuth.refresh_token(%{refresh_token: refresh_token})
  end
end
