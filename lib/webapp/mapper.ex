defmodule Webapp.Mapper do
  def remap(source, mapping, options \\ []) do
    Map.new(mapping, transform(source, options))
  end

  defmacro uri_to_id do
    quote do
      &Webapp.Mapper.from_uri/1
    end
  end

  defmacro uri_to_id(nth) do
    quote do
      {&Webapp.Mapper.from_uri/2, unquote(nth)}
    end
  end

  def from_uri(uri, nth \\ :last)

  def from_uri(nil, _) do
    nil
  end

  def from_uri(uri, nth) do
    path = String.split(uri, "/")
    case nth do
      :last -> List.last(path)
      _     -> Enum.at(path, nth)
    end
  end

  defp transform(source, options) do
    fn({key, mapping}) ->
      {key, convert(find(source, root(options) ++ path(mapping)), mapping)}
    end
  end

  defp find(source, properties), do: find(source, properties, nil)

  defp find(_source, [], result) do
    result
  end

  defp find(source, [property | properties], _result) do
    case Map.fetch(source, property) do
      :error       -> nil
      {:ok, value} -> find(value, properties, value)
    end
  end

  defp convert(value, [_ | funs]), do: Enum.reduce(funs, value, &apply_fn/2)
  defp convert(value, _), do: value

  defp apply_fn({f, arg}, value), do: f.(value, arg)
  defp apply_fn(f, value), do: f.(value)

  defp root(options) do
    case options[:root] do
      nil  -> []
      root -> path(root)
    end
  end

  defp path([properties | _]), do: path(properties)
  defp path(properties), do: String.split(properties, ".")
end
