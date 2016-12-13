defmodule Webapp.Schema.Interfaces.Meta do
  use Absinthe.Schema.Notation

  interface :meta do
    field :title, :string
    field :identifier, :string
    field :id, :id
    field :url, :string
    field :category, :string

    field :author, :user
    field :contributor, :user

    field :used_by, list_of(:meta)
    field :using, list_of(:meta)

    resolve_type fn
      %{category: "attribute"}, _ -> :attribute
      %{category: "attributeDisplayForm"}, _ -> :attribute_display_form
      %{category: "column"}, _ -> :column
      %{category: "dataLoadingColumn"}, _ -> :data_loading_column
      %{category: "dataSet"}, _ -> :dataset
      %{category: "dimension"}, _ -> :dimension
      %{category: "domain"}, _ -> :domain
      %{category: "executionContext"}, _ -> :execution_context
      %{category: "fact"}, _ -> :fact
      %{category: "folder"}, _ -> :folder
      %{category: "metric"}, _ -> :metric
      %{category: "projectDashboard"}, _ -> :project_dashboard
      %{category: "prompt"}, _ -> :prompt
      %{category: "report"}, _ -> :report
      %{category: "reportDefinition"}, _ -> :report_definition
      %{category: "scheduledMail"}, _ -> :scheduled_mail
      %{category: "table"}, _ -> :table
      %{category: "tableDataLoad"}, _ -> :table_data_load
      %{category: "visualization"}, _ -> :visualization
    end
  end
end
