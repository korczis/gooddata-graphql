defmodule Webapp.Schema.Types.User do
  use Absinthe.Schema.Notation

  @desc "User"
  object :user do
    field :id, :id
    field :url, :string
    field :email, :string
    field :language, :string
    field :login, :string
    field :position, :string
    field :timezone, :string
    field :created, :string
    field :updated, :string
  end
end
