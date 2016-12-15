defmodule Webapp.Schema.Types.Item.ReportItem do
  use Absinthe.Schema.Notation

  @desc "Report Item"
  object :report_item do
    field :position_x, :integer
    field :position_y, :integer
    field :size_x, :integer
    field :size_y, :integer

    interface :item
  end
end
