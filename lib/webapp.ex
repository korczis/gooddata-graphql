defmodule Webapp do
  require Logger
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    Logger.info "Using #{Application.get_env(:webapp, Webapp.Endpoint)[:gooddata][:host]}"
    # Define workers and child supervisors to be supervised
    children = [
      # Start the endpoint when the application starts
      supervisor(Webapp.Endpoint, []),
      worker(Cachex, [:rest_cache, [default_ttl: :timer.seconds(60), limit: 1000]])
      # Start your own worker by calling: Webapp.Worker.start_link(arg1, arg2, arg3)
      # worker(Webapp.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Webapp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Webapp.Endpoint.config_change(changed, removed)
    :ok
  end
end
