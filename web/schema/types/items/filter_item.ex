defmodule Webapp.Schema.Types.Item.FilterItem do
  use Absinthe.Schema.Notation

  @desc "Filter Item"
  object :filter_item do
    field :position_x, :integer
    field :position_y, :integer
    field :size_x, :integer
    field :size_y, :integer
    field :category, :string

    interface :item
  end
end
