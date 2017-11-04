defmodule CronExperimentTest do
  use ExUnit.Case
  doctest CronExperiment

  test "greets the world" do
    assert CronExperiment.hello() == :world
  end
end
