defmodule Webapp.Schema.Types.DataResult do
  use Absinthe.Schema.Notation

  @desc "Data Result"
  object :data_result do
    field :data, list_of(list_of(:string))
    field :json, :string
  end
end
