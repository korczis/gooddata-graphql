defmodule Webapp.Schema.Types.Item.HeadlineItem do
  use Absinthe.Schema.Notation

  @desc "Headline Item"
  object :headline_item do
    field :position_x, :integer
    field :position_y, :integer
    field :size_x, :integer
    field :size_y, :integer

    interface :item
  end
end
