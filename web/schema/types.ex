defmodule Webapp.Schema.Types do
  use Absinthe.Schema.Notation

  import_types Webapp.Schema.Types.Fact
  import_types Webapp.Schema.Types.Permissions
  import_types Webapp.Schema.Types.Project
  import_types Webapp.Schema.Types.Role
  import_types Webapp.Schema.Types.User
end
