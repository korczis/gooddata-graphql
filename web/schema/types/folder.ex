defmodule Webapp.Schema.Types.Folder do
  use Absinthe.Schema.Notation

  @desc "Folder"
  object :folder do
    field :link, :string
    field :locked, :string
    field :author, :user, resolve: fn(_args, info) ->
      Webapp.UserResolver.find(%{id: info.source.author}, info)
    end
    field :tags, :string
    field :created, :string
    field :identifier, :string
    field :deprecated, :string
    field :summary, :string
    field :is_production, :string
    field :title, :string
    field :category, :string
    field :updated, :string
    field :unlisted, :string
    field :contributor, :user, resolve: fn(_args, info) ->
      Webapp.UserResolver.find(%{id: info.source.contributor}, info)
    end
    field :type, :string
  end
end
