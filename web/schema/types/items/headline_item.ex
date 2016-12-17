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
    field :metric, :metric, resolve: fn(_args, info) ->
      Webapp.ObjectResolver.get_metric(%{url: info.source.metric}, info)
    end
    field :display_form, :attribute_display_form, resolve: fn(_args, info) ->
      Webapp.ObjectResolver.get_attribute_display_form(%{url: info.source.display_form}, info)
    end

    interface :item
  end
end
