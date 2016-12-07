defmodule Webapp.Schema.Types.Project do
  use Absinthe.Schema.Notation

  @desc "Project"
  object :project do
    field :id, :id
    field :url, :string
    # Content
    field :cluster, :string
    field :driver, :string
    field :environment, :string
    field :guided_navigation, :string
    field :is_public, :string
    field :state, :string
    # Meta
    field :summary, :string
    field :title, :string
    field :created, :string
    field :updated, :string
    # Other
    field :roles, list_of(:role) do
      resolve &Webapp.RoleResolver.find_multiple/3
    end
    field :attributes, list_of(:attribute), resolve: fn(_args, info) ->
      Webapp.ObjectResolver.find_attributes(%{project: info.source.id}, info)
    end
    field :facts, list_of(:fact), resolve: fn(_args, info) ->
      Webapp.ObjectResolver.find_facts(%{project: info.source.id}, info)
    end
    field :tables, list_of(:table), resolve: fn(_args, info) ->
      Webapp.ObjectResolver.find_tables(%{project: info.source.id}, info)
    end
    field :table_data_loads, list_of(:table_data_load), resolve: fn(_args, info) ->
      Webapp.ObjectResolver.find_table_data_loads(%{project: info.source.id}, info)
    end
    field :author, :user, resolve: fn(_args, info) ->
      Webapp.UserResolver.find(%{id: info.source.author}, info)
    end
    field :contributor, :user, resolve: fn(_args, info) ->
      Webapp.UserResolver.find(%{id: info.source.contributor}, info)
    end
  end
end
