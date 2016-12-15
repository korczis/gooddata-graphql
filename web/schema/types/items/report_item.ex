defmodule Webapp.Schema.Types.Item.ReportItem do
  use Absinthe.Schema.Notation

  @desc "Report Item"
  object :report_item do
    field :position_x, :integer
    field :position_y, :integer
    field :size_x, :integer
    field :size_y, :integer

    field :report, :report, resolve: fn(_args, info) ->
      {:ok, %{}}
    end

    interface :item
  end
end
