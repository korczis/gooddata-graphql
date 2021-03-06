defmodule Webapp.Router do
  use Webapp.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_cookies
    plug Webapp.TTRefresh
  end

  pipeline :graphql do
    plug :fetch_cookies
    plug Webapp.TTRefresh
    plug Webapp.Context
  end

  scope "/api/v1", as: :api_v1, alias: Webapp.API.V1 do
    pipe_through :api

    post "/auth/signin", AuthController, :sign_in
    post "/auth/signout", AuthController, :sign_out
    get "/proxy/*path", ProxyController, :proxy
    get  "/auth/user", AuthController, :user
  end

  scope "/graphiql" do
    pipe_through :graphql

    get "/", Absinthe.Plug.GraphiQL, schema: Webapp.Schema
    post "/", Absinthe.Plug.GraphiQL, schema: Webapp.Schema
  end

  scope "/graphql" do
    pipe_through :graphql

    forward "/", Absinthe.Plug, schema: Webapp.Schema
  end

  scope "/", Webapp do
    pipe_through :browser # Use the default browser stack

    # get "/", PageController, :index
    get "/*path", PageController, :index
  end
end
