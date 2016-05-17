defmodule Rumbl do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(Rumbl.Endpoint, []),
      supervisor(Rumbl.Repo, []),
      worker(Rumbl.Counter,[5]),
    ]
    opts = [strategy: :one_for_one, name: Rumbl.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    Rumbl.Endpoint.config_change(changed, removed)
    :ok
  end
end
