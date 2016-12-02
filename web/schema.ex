defmodule Webapp.Schema do
  use Absinthe.Schema
  import_types Webapp.Schema.Types

  query do
    field :projects, list_of(:project) do
      resolve &Webapp.ProjectResolver.all/2
    end
  end
end
