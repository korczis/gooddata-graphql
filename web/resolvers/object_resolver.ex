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
  ] ++ @mapping

  @data_loading_column [
  ] ++ @mapping

  @dataset [
    mode: "mode",
    attributes: "content.attributes",
    data_loading_columns: "content.dataLoadingColumns",
    facts: "content.facts"
  ] ++ @mapping

  @fact [
    exprs: "content.expr"
  ] ++ @mapping

  @table [
    active_data_load: "content.activeDataLoad",
    table_db_name: "content.tableDBName",
  ] ++ @mapping

  @table_data_load [
    type_of_load: "content.typeOfLoad",
    data_source_location: "content.dataSourceLocation"
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
