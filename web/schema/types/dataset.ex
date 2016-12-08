defmodule Webapp.Schema.Types.Dataset do
  use Absinthe.Schema.Notation

  @desc "Dataset"
  object :dataset do
    field :author, :user, resolve: fn(_args, info) ->
      Webapp.UserResolver.find(%{id: info.source.author}, info)
    end
    field :created, :string
    field :contributor, :user, resolve: fn(_args, info) ->
      Webapp.UserResolver.find(%{id: info.source.contributor}, info)
    end
    # Content
    field :mode, :string
    field :attributes, list_of(:attribute), resolve: fn(_args, info) ->
      Webapp.ObjectResolver.find_list_of_attributes(%{urls: info.source.attributes}, info)
    end
    field :data_loading_columns, list_of(:data_loading_column), resolve: fn(_args, info) ->
      Webapp.ObjectResolver.find_list_of_data_loading_columns(%{urls: info.source.data_loading_columns}, info)
    end
    field :facts, list_of(:fact), resolve: fn(_args, info) ->
      Webapp.ObjectResolver.find_list_of_facts(%{urls: info.source.facts}, info)
    end
    # Meta
    field :deprecated, :string
    field :id, :id
    field :identifier, :string
    field :is_production, :string
    field :summary, :string
    field :tags, :string
    field :title, :string
    field :updated, :string
    field :category, :string
    field :url, :string
    interface :meta
  end
end
