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

    resolve_type fn
      %{category: "metric"}, _ -> :metric
      %{category: "fact"}, _ -> :fact
      %{category: "column"}, _ -> :column
      %{category: "attribute"}, _ -> :attribute
      %{category: "dataSet"}, _ -> :dataset
      %{category: "attributeDisplayForm"}, _ -> :attribute_display_form
      %{category: "reportDefinition"}, _ -> :report_definition
      %{category: "projectDashboard"}, _ -> :project_dashboard
      %{category: "domain"}, _ -> :domain
      %{category: "report"}, _ -> :report
    end
  end
end
