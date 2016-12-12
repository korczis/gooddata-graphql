defmodule Webapp.Schema.Types.Report do
  use Absinthe.Schema.Notation

  @desc "Report"
  object :report do
    field :id, :id
    field :url, :string
    field :title, :string
    field :category, :string
    field :identifier, :string
    field :definitions, list_of(:string)
    field :data, :string, resolve: &Webapp.ObjectResolver.get_report_data/2
    field :author, :user, resolve: fn(_args, info) ->
      Webapp.UserResolver.find(%{id: info.source.author}, info)
    end
    field :contributor, :user, resolve: fn(_args, info) ->
      Webapp.UserResolver.find(%{id: info.source.contributor}, info)
    end
    interface :meta
  end
end
