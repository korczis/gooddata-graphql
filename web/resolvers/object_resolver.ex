defmodule Webapp.ObjectResolver do
  require Webapp.Mapper

  import Webapp.Mapper, only: [uri_to_id: 0, remap: 3]

  @mapping [
    id: ["meta.uri", uri_to_id],
    url: "meta.uri"
  ]

  @fact [
  ] ++ @mapping

  def find_facts(%{project: id}, info) do
    res = objects_query(id, "fact", info.context.cookies)
    {:ok, Enum.map(res, &(remap(&1, @fact, root: "fact")))}
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
