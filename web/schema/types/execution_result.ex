defmodule Webapp.Schema.Types.ExecutionResult do
  use Absinthe.Schema.Notation

  @desc "Execution Result"
  object :execution_result do
    field :report_name, :string
    field :format, :string
    field :data_result, :data_result do
      resolve &Webapp.ObjectResolver.get_data_result/2
    end
  end
end
