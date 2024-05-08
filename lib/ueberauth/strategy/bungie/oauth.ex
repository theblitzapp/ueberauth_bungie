defmodule Ueberauth.Strategy.Bungie.OAuth do
  @moduledoc """
  Oauth2 Strategy for Bungie
  """
  use OAuth2.Strategy

  @defaults [
    strategy: __MODULE__,
    site: "https://www.bungie.net/Platform",
    authorize_url: "https://www.bungie.net/en/OAuth/Authorize",
    token_url: "https://www.bungie.net/Platform/App/OAuth/token/",
    token_method: :post
  ]

  def client(opts \\ []) do
    config =
      :ueberauth
      |> Application.fetch_env!(Ueberauth.Strategy.Bungie.OAuth)
      |> check_config_key_exists(:client_id)
      |> check_config_key_exists(:client_secret)
      |> check_config_key_exists(:api_key)

    opts =
      @defaults
      |> Keyword.merge(config)
      |> Keyword.merge(opts)

    opts
    |> OAuth2.Client.new()
    |> put_header("X-API-Key", config[:api_key])
    |> OAuth2.Client.put_serializer("application/json", Jason)
  end


  def authorize_url!(opts) do
    OAuth2.Client.authorize_url!(client(), opts)
  end

  # you can pass options to the underlying http library via `opts` parameter
  def get_token!(params \\ [], headers \\ [], opts \\ []) do
    OAuth2.Client.get_token!(client(), params, headers, opts)
  end

  def get_token(client, params, headers) do
    client
    |> get_access_token(params, headers)
  end

  def get(token, url, headers \\ [], opts \\ []) do
    [token: token]
    |> client()
    |> OAuth2.Client.get(url, headers, opts)
  end

  # Strategy Callbacks

  def authorize_url(client, params) do
    OAuth2.Strategy.AuthCode.authorize_url(client, params)
  end

  def get_access_token(client, params, headers) do
    {code, params} = Keyword.pop(params, :code, client.params["code"])

    unless code do
      raise OAuth2.Error, reason: "Missing required key `code` for `#{inspect(__MODULE__)}`"
    end

    client
    |> put_param(:code, code)
    |> put_param(:grant_type, "authorization_code")
    |> put_param(:client_id, client.client_id)
    |> put_param(:client_secret, client.client_secret)
    |> merge_params(params)
    |> put_headers(headers)
  end

  defp check_config_key_exists(config, key) when is_list(config) do
    unless Keyword.has_key?(config, key) do
      raise "#{inspect(key)} missing from config :ueberauth, Ueberauth.Strategy.Bungie"
    end

    config
  end

  defp check_config_key_exists(_, _) do
    raise "Config :ueberauth, Ueberauth.Strategy.Bungie is not a keyword list, as expected"
  end
end
