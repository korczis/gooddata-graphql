defmodule Webapp.Schema.Types.ProjectDashboard do
  use Absinthe.Schema.Notation

  object :project_dashboard do
    field :title, :string
    field :identifier, :string
    field :id, :id
    field :url, :string
    field :category, :string
    field :author, :user, resolve: fn(_args, info) ->
      Webapp.UserResolver.find(%{id: info.source.author}, info)
    end
    field :contributor, :user, resolve: fn(_args, info) ->
      Webapp.UserResolver.find(%{id: info.source.contributor}, info)
    end
    field :used_by, list_of(:meta) do
      resolve &Webapp.ObjectResolver.find_used_by/2
    end
    field :using, list_of(:meta) do
      resolve &Webapp.ObjectResolver.find_using/2
    end
    field :tabs, list_of(:project_dashboard_tab) do
      resolve &Webapp.ObjectResolver.transform_tabs/2
    end
    interface :meta
  end
end
