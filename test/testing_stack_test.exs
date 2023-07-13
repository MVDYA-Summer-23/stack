defmodule TestingStackTest do
  use ExUnit.Case
  doctest TestingStack

  test "greets the world" do
    assert TestingStack.hello() == :world
  end
end
