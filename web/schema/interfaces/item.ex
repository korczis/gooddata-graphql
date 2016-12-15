defmodule Webapp.Schema.Interfaces.Item do
  use Absinthe.Schema.Notation

  interface :item do
    field :position_x, :integer
    field :position_y, :integer
    field :size_x, :integer
    field :size_y, :integer

    resolve_type fn
      %{category: "headlineItem"}, _ -> :headline_item
      %{category: "iframeItem"}, _ -> :iframe_item
      %{category: "reportItem"}, _ -> :report_item
    end
  end
end
