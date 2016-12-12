defmodule Webapp.Schema.Types.ReportDefinition do
  use Absinthe.Schema.Notation

  object :report_definition do
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
    interface :meta
  end
end
