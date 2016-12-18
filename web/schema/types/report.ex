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
    field :result, :execution_result, resolve: &Webapp.ObjectResolver.get_report_result/2
    field :data, :string, resolve: &Webapp.ObjectResolver.get_report_data/2
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
