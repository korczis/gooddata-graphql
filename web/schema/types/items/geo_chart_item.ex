defmodule Webapp.Schema.Types.Item.GeoChartItem do
  use Absinthe.Schema.Notation

  @desc "Geo Chart Item"
  object :geo_chart_item do
    field :position_x, :integer
    field :position_y, :integer
    field :size_x, :integer
    field :size_y, :integer
    field :category, :string

    interface :item
  end
end
