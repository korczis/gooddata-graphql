defmodule Webapp.Schema.Types.Domain do
  use Absinthe.Schema.Notation

  object :domain do
    field :title, :string
    field :identifier, :string
    field :id, :id
    field :url, :string
    field :category, :string
    interface :meta

    field :author, :user, resolve: fn(_args, info) ->
      Webapp.UserResolver.find(%{id: info.source.author}, info)
    end
    field :contributor, :user, resolve: fn(_args, info) ->
      Webapp.UserResolver.find(%{id: info.source.contributor}, info)
    end
    field :used_by, list_of(:meta) do
      resolve &Webapp.ObjectResolver.find_used_by/2
    end
    field :using, list_of(:meta) do
      resolve &Webapp.ObjectResolver.find_using/2
    end
  end
end
