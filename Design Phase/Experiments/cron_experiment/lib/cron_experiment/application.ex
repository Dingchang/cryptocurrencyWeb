defmodule CronExperiment.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
	#worker(CronExperiment.Scheduler, [])
	{CronExperiment.Scheduler, []}
      # Starts a worker by calling: CronExperiment.Worker.start_link(arg)
      # {CronExperiment.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CronExperiment.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
