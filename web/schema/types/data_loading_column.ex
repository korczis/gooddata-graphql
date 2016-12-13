defmodule Webapp.Schema.Types.DataLoadingColumn do
  use Absinthe.Schema.Notation

  @desc "Data Loading Column"
  object :data_loading_column do
    field :author, :user, resolve: fn(_args, info) ->
      Webapp.UserResolver.find(%{id: info.source.author}, info)
    end
    field :created, :string
    field :contributor, :user, resolve: fn(_args, info) ->
      Webapp.UserResolver.find(%{id: info.source.contributor}, info)
    end
    # Content
    field :column_name, :string
    field :column_unique, :integer
    field :column_precision, :integer
    field :column_null, :integer
    field :column_type, :string
    field :column_length, :integer
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
