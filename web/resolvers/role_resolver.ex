defmodule Webapp.RoleResolver do
  def all(_args, _info) do
    {:ok, []}
  end

  def find(%{id: id}, _info) do
    {:ok, %{}}
  end
end
