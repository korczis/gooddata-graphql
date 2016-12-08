defmodule Webapp.Schema.Types.Attribute do
  use Absinthe.Schema.Notation

  @desc "Attribute"
  object :attribute do
    field :author, :user, resolve: fn(_args, info) ->
      Webapp.UserResolver.find(%{id: info.source.author}, info)
    end
    field :created, :string
    field :contributor, :user, resolve: fn(_args, info) ->
      Webapp.UserResolver.find(%{id: info.source.contributor}, info)
    end
    # Content
    field :direction, :string
    field :sort, :string
    field :dimension, :string
    field :type, :string
    # Meta
    field :deprecated, :string
    field :id, :id
    field :identifier, :string
    field :is_production, :string
    field :category, :string
    field :summary, :string
    field :tags, :string
    field :title, :string
    field :updated, :string
    field :url, :string
    field :used_by, list_of(:meta) do
      resolve &Webapp.ObjectResolver.find_used_by/2
    end
    interface :meta
  end

  object :attribute_display_form do
    field :title, :string
    field :identifier, :string
    field :id, :id
    field :url, :string
    field :category, :string
    interface :meta
  end

  object :report_definition do
    field :title, :string
    field :identifier, :string
    field :id, :id
    field :url, :string
    field :category, :string
    interface :meta
  end

  object :project_dashboard do
    field :title, :string
    field :identifier, :string
    field :id, :id
    field :url, :string
    field :category, :string
    interface :meta
  end

  object :domain do
    field :title, :string
    field :identifier, :string
    field :id, :id
    field :url, :string
    field :category, :string
    interface :meta
  end

  interface :meta do
    field :title, :string
    field :identifier, :string
    field :id, :id
    field :url, :string
    field :category, :string

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
