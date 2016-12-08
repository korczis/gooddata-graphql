defmodule Webapp.ObjectResolver do
  require Webapp.Mapper

  import Webapp.Mapper, only: [uri_to_id: 0, remap: 3, remap: 2]

  @mapping [
    author: ["meta.author", uri_to_id],
    category: "meta.category",
    contributor: ["meta.contributor", uri_to_id],
    created: "meta.created",
    deprecated: "meta.deprecated",
    id: ["meta.uri", uri_to_id],
    identifier: "meta.identifier",
    is_production: "meta.isProduction",
    summary: "meta.summary",
    tags: "meta.tags",
    title: "meta.title",
    updated: "meta.updated",
    url: "meta.uri"
  ]

  @attribute [
    dimension: "content.dimension",
    direction: "content.direction",
    sort: "content.sort",
    type: "content.type",
  ] ++ @mapping

  @column [
    column_db_name: "content.columnDBName",
    table: "content.table",
  ] ++ @mapping

  @data_loading_column [
    column_name: "content.columnName",
    column_unique: "content.columnUnique",
    column_precision: "content.columnPrecision",
    column_null: "content.columnNull",
    column_type: "content.columnType",
    column_length: "content.columnLength",
  ] ++ @mapping

  @dataset [
    mode: "mode",
    attributes: "content.attributes",
    data_loading_columns: "content.dataLoadingColumns",
    facts: "content.facts"
  ] ++ @mapping

  @fact [
    folders: "content.folders",
    exprs: "content.expr"
  ] ++ @mapping

  @table [
    active_data_load: "content.activeDataLoad",
    table_db_name: "content.tableDBName",
    table_data_loads: "content.tableDataLoad"
  ] ++ @mapping

  @table_data_load [
    type_of_load: "content.typeOfLoad",
    data_source_location: "content.dataSourceLocation"
  ] ++ @mapping

  @metric [
    folders: "content.folders",
    format: "content.format",
    expression: "content.expression"
  ] ++ @mapping

  @folder [
    type: "content.type",
    entries: "content.entries"
  ] ++ @mapping

  @report [
    definitions: "content.definitions"
  ] ++ @mapping

  def find_attributes(%{project: id}, info) do
    res = objects_query(id, "attribute", info.context.cookies)
    {:ok, Parallel.map(res, &(remap(&1, @attribute, root: "attribute")))}
  end

  def find_list_of_attributes(%{urls: urls}, info) do
    attributes = Parallel.map(
      urls,
      fn(url) ->
        res = Poison.decode!(Webapp.Request.get(url, info.context.cookies).body)
        remap(res, @attribute, root: "attribute")
      end
    )
    {:ok, attributes}
  end


  def find_columns(%{project: id}, info) do
    res = objects_query(id, "column", info.context.cookies)
    {:ok, Parallel.map(res, &(remap(&1, @column, root: "column")))}
  end

  def find_data_loading_columns(%{project: id}, info) do
    res = objects_query(id, "dataLoadingColumn", info.context.cookies)
    {:ok, Parallel.map(res, &(remap(&1, @data_loading_column, root: "dataLoadingColumn")))}
  end

  def find_list_of_data_loading_columns(%{urls: urls}, info) do
    data_loading_columns = Parallel.map(
      urls,
      fn(url) ->
        res = Poison.decode!(Webapp.Request.get(url, info.context.cookies).body)
        remap(res, @data_loading_column, root: "dataLoadingColumn")
      end
    )
    {:ok, data_loading_columns}
  end

  def find_datasets(%{project: id}, info) do
    res = objects_query(id, "dataSet", info.context.cookies)
    {:ok, Parallel.map(res, &(remap(&1, @dataset, root: "dataSet")))}
  end

  def find_facts(%{project: id}, info) do
    res = objects_query(id, "fact", info.context.cookies)
    {:ok, Parallel.map(res, &(remap(&1, @fact, root: "fact")))}
  end

  def find_list_of_facts(%{urls: urls}, info) do
    facts = Parallel.map(
      urls,
      fn(url) ->
        res = Poison.decode!(Webapp.Request.get(url, info.context.cookies).body)
        remap(res, @fact, root: "fact")
      end
    )
    {:ok, facts}
  end

  def find_table_by_url(%{url: url}, info) do
    res = Poison.decode!(Webapp.Request.get(url, info.context.cookies).body)
    {:ok, remap(res, @table, root: "table")}
  end

  def find_table_data_load_by_url(%{url: url}, info) do
    res = Poison.decode!(Webapp.Request.get(url, info.context.cookies).body)
    {:ok, remap(res, @table_data_load, root: "tableDataLoad")}
  end

  def find_table_data_loads_by_url(%{urls: urls}, info) do
    table_data_loads = Parallel.map(
      urls,
      fn(url) ->
        res = Poison.decode!(Webapp.Request.get(url, info.context.cookies).body)
        remap(res, @table_data_load, root: "tableDataLoad")
      end
    )
    {:ok, table_data_loads}
  end

  def find_table_data_loads(%{project: id}, info) do
    res = objects_query(id, "tableDataLoad", info.context.cookies)
    {:ok, Parallel.map(res, &(remap(&1, @table_data_load, root: "tableDataLoad")))}
  end

  def find_tables(%{project: id}, info) do
    res = objects_query(id, "table", info.context.cookies)
    {:ok, Parallel.map(res, &(remap(&1, @table, root: "table")))}
  end

  def get_exprs(_args, info) do
    exprs = Enum.map(info.source.exprs, fn(%{"data" => path, "type" => type}) ->
      res = Poison.decode!(Webapp.Request.get(path, info.context.cookies).body)
      remap(res, @column, root: "column")
    end)
    {:ok, exprs}
  end

  def fetch_folder_entries(_args, info) do
    entries = Enum.map(info.source.entries, fn(%{"link" => path, "category" => category}) ->
        res = Poison.decode!(Webapp.Request.get(path, info.context.cookies).body)
        case category do
          "metric" -> remap(res, @metric, root: "metric")
          "fact" -> remap(res, @fact, root: "fact")
        end
    end)
    {:ok, entries}
  end

  def find_metrics(%{project: id}, info) do
    res = objects_query(id, "metric", info.context.cookies)
    {:ok, Enum.map(res, &(remap(&1, @metric, root: "metric")))}
  end

  def find_folders(%{folders: uris}, info) do
    result = Enum.map(uris,
      fn uri ->
        res_j = Poison.decode!(Webapp.Request.get(uri, info.context.cookies).body())
        res = get_in(res_j, ["folder"])
        remap(res, @folder)
      end
    )
    {:ok, result}
  end

  def find_report(%{id: id}, info) do
    uri = "/gdc/md/#{info.source.id}/obj/#{id}"
    res = Poison.decode!(Webapp.Request.get(uri, info.context.cookies).body())
    report = remap(res, @report, root: "report")
    {:ok, report}
  end

  def find_reports(_arg, info) do
    res = objects_query(info.source.id, "report", info.context.cookies)
    {:ok, Enum.map(res, &(remap(&1, @report, root: "report")))}
  end

  def get_report_data(_arg, info) do
    {:ok, export_report(info.source.url, info.context.cookies)}
  end

  defp export_report(uri, cookies) do
    project = Enum.at(String.split(uri, "/"), 3)
    path = "/gdc/app/projects/#{project}/execute/raw/"
    payload = %{
      report_req: %{
        report: uri
      }
    }
    res = Poison.decode!(Webapp.Request.post(path, payload, cookies).body)
    Webapp.Request.get(Map.get(res, "uri"), cookies).body
  end

  defp objects_query(project, category, cookies) do
    query("/gdc/md/#{project}/objects/query?category=#{category}&limit=50", cookies)
  end

  defp query(path, cookies, acc \\ []) do
    res = Poison.decode!(Webapp.Request.get(path, cookies).body)
    items = [acc, get_in(res, ["objects", "items"])]
    paging = get_in(res, ["objects", "paging"])
    case Map.get(paging, "next") do
      nil  -> List.flatten(items)
      next -> query(next, cookies, items)
    end
  end
end
