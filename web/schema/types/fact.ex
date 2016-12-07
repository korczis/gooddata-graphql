defmodule Webapp.Schema.Types.Fact do
  use Absinthe.Schema.Notation

  @desc "Fact"
  object :fact do
    field :id, :id
    field :url, :string
  end
end
