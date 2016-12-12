defmodule Webapp.Schema.Types.Attribute do
  use Absinthe.Schema.Notation

  @desc "Attribute"
  object :attribute do
    field :author, :user, resolve: fn(_args, info) ->
      Webapp.UserResolver.find(%{id: info.source.author}, info)
    end
    field :created, :string
    field :contributor, :user, resolve: fn(_args, info) ->
      Webapp.UserResolver.find(%{id: info.source.contributor}, info)
    end
    # Content
    field :direction, :string
    field :sort, :string
    field :dimension, :string
    field :type, :string
    # Meta
    field :deprecated, :string
    field :id, :id
    field :identifier, :string
    field :is_production, :string
    field :category, :string
    field :summary, :string
    field :tags, :string
    field :title, :string
    field :updated, :string
    field :url, :string
    field :used_by, list_of(:meta) do
      resolve &Webapp.ObjectResolver.find_used_by/2
    end
    field :using, list_of(:meta) do
      resolve &Webapp.ObjectResolver.find_using/2
    end
    interface :meta
  end
end
