defmodule Ice.Application do
  use Application

  def start(_type, _args) do
    port = String.to_integer(System.get_env("SERVER_PORT", "4000"))

    children = [
      Ice.Repo,
      {Plug.Cowboy, scheme: :http, plug: Ice.Router, options: [port: port]}
    ]

    opts = [strategy: :one_for_one, name: Ice.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
