defmodule Webapp.Schema.Types.Column do
  use Absinthe.Schema.Notation

  @desc "Column"
  object :column do
    field :author, :user, resolve: fn(_args, info) ->
      Webapp.UserResolver.find(%{id: info.source.author}, info)
    end
    field :created, :string
    field :contributor, :user, resolve: fn(_args, info) ->
      Webapp.UserResolver.find(%{id: info.source.contributor}, info)
    end
    field :table, :table, resolve: fn(_args, info) ->
      Webapp.ObjectResolver.find_table_by_url(%{url: info.source.table}, info)
    end
    # Content
    # field :column_db_name, :string
    # Meta
    field :category, :string
    field :deprecated, :string
    field :id, :id
    field :identifier, :string
    field :is_production, :string
    field :summary, :string
    field :tags, :string
    field :title, :string
    field :updated, :string
    field :url, :string
  end
end
