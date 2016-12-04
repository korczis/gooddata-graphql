defmodule Webapp.MapperTest do
  use ExUnit.Case, async: true

  require Webapp.Mapper

  import Webapp.Mapper, only: [uri_to_id: 0, uri_to_id: 1, remap: 2, remap: 3]

  @mapping [
    desc: "meta.desc",
    id: ["links.self", uri_to_id],
    project: ["links.project", uri_to_id(4)],
    title: "meta.title",
    user: ["links.user", uri_to_id(4)]
  ]

  @expected %{
    desc: nil,
    id: "test_id",
    project: nil,
    title: "test_title",
    user: "user_id"
  }

  @json_without_root %{
    "links" => %{
      "self" => "/path/to/project/test_id",
      "user" => "/path/to/user/user_id/something"
    },
    "meta" => %{
      "title" => "test_title"
    }
  }

  @json_with_root %{
    "project" => @json_without_root
  }

  @json_with_deep_root %{
    "deep" => @json_with_root
  }

  test "remap without root" do
    assert @expected == remap(@json_without_root, @mapping)
  end

  test "remap with root" do
    assert @expected == remap(@json_with_root, @mapping, root: "project")
  end

  test "remap with deep root" do
    assert @expected == remap(@json_with_deep_root, @mapping, root: "deep.project")
  end
end
