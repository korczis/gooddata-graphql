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
    field :attributes, list_of(:attribute) do
      arg :title, :string
      arg :identifier, :string
      resolve &Webapp.ObjectResolver.find_attributes/2
    end
    field :columns, list_of(:column) do
      arg :title, :string
      arg :identifier, :string
      resolve &Webapp.ObjectResolver.find_columns/2
    end
    field :data_loading_columns, list_of(:data_loading_column) do
      arg :title, :string
      arg :identifier, :string
      resolve &Webapp.ObjectResolver.find_data_loading_columns/2
    end
    field :datasets, list_of(:dataset) do
      arg :title, :string
      arg :identifier, :string
      resolve &Webapp.ObjectResolver.find_datasets/2
    end
    field :facts, list_of(:fact), resolve: fn(_args, info) ->
      Webapp.ObjectResolver.find_facts(%{project: info.source.id}, info)
    end
    field :tables, list_of(:table) do
      arg :title, :string
      arg :identifier, :string
      resolve &Webapp.ObjectResolver.find_tables/2
    end
    field :table_data_loads, list_of(:table_data_load) do
      arg :title, :string
      arg :identifier, :string
      resolve &Webapp.ObjectResolver.find_table_data_loads/2
    end
    field :author, :user, resolve: fn(_args, info) ->
      Webapp.UserResolver.find(%{id: info.source.author}, info)
    end
    field :contributor, :user, resolve: fn(_args, info) ->
      Webapp.UserResolver.find(%{id: info.source.contributor}, info)
    end
    field :report, :report do
      arg :id, non_null(:id)
      resolve &Webapp.ObjectResolver.find_report/2
    end
    field :reports, list_of(:report) do
      resolve &Webapp.ObjectResolver.find_reports/2
    end
  end
end
