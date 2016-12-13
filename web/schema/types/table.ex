defmodule Webapp.Schema.Types.Table do
  use Absinthe.Schema.Notation

  @desc "Table"
  object :table do
    field :author, :user, resolve: fn(_args, info) ->
      Webapp.UserResolver.find(%{id: info.source.author}, info)
    end
    field :created, :string
    field :contributor, :user, resolve: fn(_args, info) ->
      Webapp.UserResolver.find(%{id: info.source.contributor}, info)
    end
    # Content
    field :active_data_load, :table_data_load, resolve: fn(_args, info) ->
      Webapp.ObjectResolver.find_table_data_load_by_url(%{url: info.source.active_data_load}, info)
    end
    field :table_data_loads, list_of(:table_data_load), resolve: fn(_args, info) ->
      Webapp.ObjectResolver.find_table_data_loads_by_url(%{urls: info.source.table_data_loads}, info)
    end
    field :table_db_name, :string
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
