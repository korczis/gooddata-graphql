defmodule Webapp.Schema.Types.Metric do
  use Absinthe.Schema.Notation

  @desc "Metric"
  object :metric do
    field :format, :string
    field :expression, :string
    field :folders, list_of(:folder), resolve: fn(_args, info) ->
      Webapp.ObjectResolver.find_folders(%{folders: info.source.folders || []}, info)
    end
  end
end
