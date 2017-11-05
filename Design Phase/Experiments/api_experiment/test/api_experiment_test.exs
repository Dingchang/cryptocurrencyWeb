defmodule ApiExperimentTest do
  use ExUnit.Case
  doctest ApiExperiment

  test "greets the world" do
    assert ApiExperiment.hello() == :world
  end
end
