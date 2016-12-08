defmodule Webapp.Schema.Types.Metric do
  use Absinthe.Schema.Notation

  @desc "Metric"
  object :metric do
    field :format, :string
    field :expression, :string
    field :folders, list_of(:folder), resolve: fn(_args, info) ->
      Webapp.ObjectResolver.find_folders(%{folders: info.source.folders || []}, info)
    end
    field :title, :string
    field :identifier, :string
    field :id, :id
    field :url, :string
    field :category, :string
    interface :meta
  end
end
