defmodule Webapp.ProjectResolver do
  def all(_args, info) do
    IO.inspect(info.context)
    {:ok, []}
  end
end
