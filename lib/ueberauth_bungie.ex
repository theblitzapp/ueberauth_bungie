defmodule UeberauthBungie do
  @moduledoc false

  def refresh_token(client_id, refresh_token) do
    app_client_id = :ueberauth
      |> Application.fetch_env!(Ueberauth.Strategy.Bungie.OAuth)
      |> Keyword.fetch(:client_id)

    if client_id === app_client_id do
      Ueberauth.Strategy.Bungie.OAuth.refresh_token(%{refresh_token: refresh_token})
    else
      {:error, :invalid_client_id}
    end
  end
end
