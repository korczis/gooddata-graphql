defmodule Webapp.Schema.Types.Item.IframeItem do
  use Absinthe.Schema.Notation

  @desc "Iframe Item"
  object :iframe_item do
    field :position_x, :integer
    field :position_y, :integer
    field :size_x, :integer
    field :size_y, :integer
    field :category, :string
    field :url, :string

    interface :item
  end
end
