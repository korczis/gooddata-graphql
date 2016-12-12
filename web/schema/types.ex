defmodule Webapp.Schema.Types do
  use Absinthe.Schema.Notation

  # Interfaces
  import_types Webapp.Schema.Interfaces.Meta

  # Types
  import_types Webapp.Schema.Types.Attribute
  import_types Webapp.Schema.Types.AttributeDisplayForm
  import_types Webapp.Schema.Types.Column
  import_types Webapp.Schema.Types.DataLoadingColumn
  import_types Webapp.Schema.Types.Dataset
  import_types Webapp.Schema.Types.Domain
  import_types Webapp.Schema.Types.Fact
  import_types Webapp.Schema.Types.Metric
  import_types Webapp.Schema.Types.Folder
  import_types Webapp.Schema.Types.Permissions
  import_types Webapp.Schema.Types.Project
  import_types Webapp.Schema.Types.ProjectDashboard
  import_types Webapp.Schema.Types.Report
  import_types Webapp.Schema.Types.ReportDefinition
  import_types Webapp.Schema.Types.Role
  import_types Webapp.Schema.Types.Table
  import_types Webapp.Schema.Types.TableDataLoad
  import_types Webapp.Schema.Types.User
end
