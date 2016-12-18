defmodule Webapp.Schema.Types.ProjectDashboardTab do
  use Absinthe.Schema.Notation

  object :project_dashboard_tab do
    field :title, :string
    field :identifier, :string

    field :items, list_of(:item) do
      arg :category, :string
      resolve &Webapp.ObjectResolver.transform_items/2
    end
  end
end
