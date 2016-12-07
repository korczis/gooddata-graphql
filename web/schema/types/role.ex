defmodule Webapp.Schema.Types.Role do
  use Absinthe.Schema.Notation

  @desc "Role"
  object :role do
    field :id, :id
    field :url, :string
    field :identifier, :string
    field :title, :string
    field :summary, :string
    field :created, :string
    field :updated, :string
    field :author, :user, resolve: fn(_args, info) ->
      Webapp.UserResolver.find(%{id: info.source.author}, info)
    end
    field :contributor, :user, resolve: fn(_args, info) ->
      Webapp.UserResolver.find(%{id: info.source.contributor}, info)
    end
    field :users, list_of(:user), resolve: fn(_args, info) ->
      source = Map.fetch!(info, :source)
      url = "#{Map.fetch!(source, :url)}/users"
      Webapp.UserResolver.find_role_users(%{url: url}, info)
    end
    field :guided_navigation, :string
    field :is_public, :string
  end
end
