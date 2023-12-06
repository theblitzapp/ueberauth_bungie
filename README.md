# Überauth Bungie

> Bungie Oauth2 strategy for Überauth.

This is a fork of the original `ueberauth_bungie` package at: `https://github.com/willsoto/ueberauth_bungie` that has been upgraded to support bungie.net api minimum version 2.18.1

## Installation

1. [Setup your application](https://www.bungie.net/en/Application)
2. Add `:ueberauth_bungie` to your list of dependencies in mix.exs:

```elixir
def deps do
  [
    {:ueberauth_bungie,
     override: true,
     git: "https://github.com/tiltify/ueberauth_bungie"
    }
  ]
end
```

3. Add Bungie to your Überauth configuration:

```elixir
config :ueberauth, Ueberauth,
  providers: [
    bungie: {Ueberauth.Strategy.Bungie, []}
  ]
```

4. Update your provider configuration:

```elixir
config :ueberauth, Ueberauth.Strategy.Bungie.OAuth,
  client_id: System.get_env("BUNGIE_CLIENT_ID"),
  redirect_uri: System.get_env("BUNGIE_OAUTH_REDIRECT_URI"),
  api_key: System.get_env("BUNGIE_API_KEY")
```

5. Include the Überauth plug in your controller:

```elixir
defmodule MyAppWeb.AuthController do
  use MyAppWeb, :controller

  plug(Ueberauth)

  # ...
end
```

6. Create the request and callback routes if you haven't already:

```elixir
  scope "/auth", MyAppWeb do
    pipe_through(:browser)

    get("/:provider", AuthController, :request)
    get("/:provider/callback", AuthController, :callback)
  end
```

7. Your controller needs to implement callbacks to deal with `Ueberauth.Auth` and `Ueberauth.Failure` responses. Check out the [example app](https://github.com/ueberauth/ueberauth_example) for more information.

## Documentation

Docs can be found at [https://hexdocs.pm/ueberauth_bungie](https://hexdocs.pm/ueberauth_bungie).
