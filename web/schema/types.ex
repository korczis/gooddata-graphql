defmodule Webapp.Schema.Types do
  use Absinthe.Schema.Notation

  # Interfaces
  import_types Webapp.Schema.Interfaces.Item
  import_types Webapp.Schema.Interfaces.Meta

  # Items
  import_types Webapp.Schema.Types.Item.HeadlineItem
  import_types Webapp.Schema.Types.Item.IframeItem
  import_types Webapp.Schema.Types.Item.ReportItem

  # Types
  import_types Webapp.Schema.Types.Attribute
  import_types Webapp.Schema.Types.AttributeDisplayForm
  import_types Webapp.Schema.Types.Column
  import_types Webapp.Schema.Types.DataLoadingColumn
  import_types Webapp.Schema.Types.Dataset
  import_types Webapp.Schema.Types.Dimension
  import_types Webapp.Schema.Types.Domain
  import_types Webapp.Schema.Types.ExecutionContext
  import_types Webapp.Schema.Types.Fact
  import_types Webapp.Schema.Types.Folder
  import_types Webapp.Schema.Types.Metric
  import_types Webapp.Schema.Types.Permissions
  import_types Webapp.Schema.Types.Project
  import_types Webapp.Schema.Types.ProjectDashboard
  import_types Webapp.Schema.Types.ProjectDashboardTab
  import_types Webapp.Schema.Types.Prompt
  import_types Webapp.Schema.Types.Report
  import_types Webapp.Schema.Types.ReportDefinition
  import_types Webapp.Schema.Types.Role
  import_types Webapp.Schema.Types.ScheduledMail
  import_types Webapp.Schema.Types.Table
  import_types Webapp.Schema.Types.TableDataLoad
  import_types Webapp.Schema.Types.User
  import_types Webapp.Schema.Types.Visualization
end
