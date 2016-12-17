defmodule Webapp.Schema.Types.Item.HeadlineItem do
  use Absinthe.Schema.Notation

  @desc "Headline Item"
  object :headline_item do
    field :position_x, :integer
    field :position_y, :integer
    field :size_x, :integer
    field :size_y, :integer
    field :category, :string
    field :linked_with_external_filter, :integer
    field :title, :string
    field :format, :string

    interface :item
  end
end
