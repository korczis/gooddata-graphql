defmodule Webapp.Schema.Types.Fact do
  use Absinthe.Schema.Notation

  @desc "Fact"
  object :fact do
    field :author, :user, resolve: fn(_args, info) ->
      Webapp.UserResolver.find(%{id: info.source.author}, info)
    end
    field :created, :string
    field :contributor, :user, resolve: fn(_args, info) ->
      Webapp.UserResolver.find(%{id: info.source.contributor}, info)
    end
    field :deprecated, :string
    field :exprs, list_of(:expr) do
      resolve &Webapp.ObjectResolver.get_exprs/2
    end
    field :folders, list_of(:folder), resolve: fn(_args, info) ->
      Webapp.ObjectResolver.find_folders(%{folders: info.source.folders || []}, info)
    end
    field :id, :id
    field :identifier, :string
    field :is_production, :string
    field :summary, :string
    field :tags, :string
    field :title, :string
    field :updated, :string
    field :url, :string
  end

  union :expr do
    types [:column]

    resolve_type fn
      %{category: "column"}, _ -> :column
    end
  end
end
