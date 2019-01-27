defmodule ApiServer.Application do
  @moduledoc false

  use Application

  def start(_type, _args), do:
    Supervisor.start_link(children(), opts())

  defp children do
    [
      ApiServer.Endpoint,
      NumberServer
    ]
  end

  defp opts do
    [
      strategy: :one_for_one,
      name: ApiServer.Supervisor
    ]
  end
end
