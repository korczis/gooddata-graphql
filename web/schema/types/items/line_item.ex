defmodule Webapp.Schema.Types.Item.LineItem do
  use Absinthe.Schema.Notation

  @desc "Line Item"
  object :line_item do
    field :position_x, :integer
    field :position_y, :integer
    field :size_x, :integer
    field :size_y, :integer
    field :category, :string

    interface :item
  end
end
