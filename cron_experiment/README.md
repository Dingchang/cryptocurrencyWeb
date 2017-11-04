This experiment demonstrates using Quantum (https://hexdocs.pm/quantum) to schedule tasks.

See scheduling config at: config/config.exs
And the actual task itself that is being executed: lib/task.ex

To run:
	`iex -S mix`

You will see it print a dummy message every second since that is what the scheduler is currently set to.


When we build our real project, this scheduler framework will be used to repeatedly poll our cryptocurrency API so that we are able to send updates via email to our users.
