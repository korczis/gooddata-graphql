defmodule Webapp.Schema.Types.ExecutionContext do
  use Absinthe.Schema.Notation

  @desc "Execution Context"
  object :execution_context do
    field :folders, list_of(:folder), resolve: fn(_args, info) ->
      Webapp.ObjectResolver.find_folders(%{folders: info.source.folders || []}, info)
    end
    field :title, :string
    field :identifier, :string
    field :id, :id
    field :url, :string
    field :category, :string
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
    interface :meta
  end
end
