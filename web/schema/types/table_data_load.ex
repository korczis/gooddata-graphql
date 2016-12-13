defmodule Webapp.Schema.Types.TableDataLoad do
  use Absinthe.Schema.Notation

  @desc "TableDataLoad"
  object :table_data_load do
    field :author, :user, resolve: fn(_args, info) ->
      Webapp.UserResolver.find(%{id: info.source.author}, info)
    end
    field :created, :string
    field :contributor, :user, resolve: fn(_args, info) ->
      Webapp.UserResolver.find(%{id: info.source.contributor}, info)
    end
    # Content
    field :type_of_load, :string
    field :data_source_location, :string
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
