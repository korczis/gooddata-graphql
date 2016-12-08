defmodule Webapp.Schema do
  use Absinthe.Schema
  import_types Webapp.Schema.Types

  query do
    field :projects, list_of(:project) do
      arg :owner, :string
      arg :title, :string
      arg :driver, :string
      resolve &Webapp.ProjectResolver.all/2
    end

    field :project, type: :project do
      arg :id, non_null(:id)
      resolve &Webapp.ProjectResolver.find/2
    end

    field :roles, list_of(:role) do
      resolve &Webapp.RoleResolver.all/2
    end

    field :role, type: :role do
      arg :id, non_null(:id)
      resolve &Webapp.RoleResolver.find/2
    end

    field :user, type: :user do
      arg :id, non_null(:id)
      resolve &Webapp.UserResolver.find/2
    end

    field :attributes, list_of(:attribute) do
      arg :project, non_null(:id)
      resolve &Webapp.ObjectResolver.find_attributes/2
    end

    field :facts, list_of(:fact) do
      arg :project, non_null(:id)
      resolve &Webapp.ObjectResolver.find_facts/2
    end

    field :table_data_loads, list_of(:table_data_load) do
      arg :project, non_null(:id)
      resolve &Webapp.ObjectResolver.find_table_data_loads/2
    end

    field :tables, list_of(:table) do
      arg :project, non_null(:id)
      resolve &Webapp.ObjectResolver.find_tables/2
    end

    field :metrics, list_of(:metric) do
      arg :project, non_null(:id)
      resolve &Webapp.ObjectResolver.find_metrics/2
    end
  end
end
