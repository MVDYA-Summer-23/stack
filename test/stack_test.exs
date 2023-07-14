defmodule StackTest do
  use ExUnit.Case
  doctest Stack

  test "start_link/1 default state is empty list" do
    {:ok, pid} = Stack.start_link([])
    assert Stack.pop(pid) == []
  end

  test "start_link/2 configured state is a list of 3 paper plates" do
    {:ok, pid} = Stack.start_link(["pink plate", "blue plate", "purple plate"])
    assert :sys.get_state(pid) == ["pink plate", "blue plate", "purple plate"]
  end

  test "pop/1 removes returns empty stack when given empty stack" do
    {:ok, pid} = Stack.start_link([])
    assert Stack.pop(pid) == []
  end

  test "pop/1 - remove one element from stack" do
    {:ok, pid} = Stack.start_link(["pink plate", "blue plate", "purple plate"])
    assert Stack.pop(pid) == "pink plate"
  end

  test "pop/1 - remove multiple elements from stack" do
    {:ok, pid} = Stack.start_link(["pink plate", "blue plate", "purple plate"])
    assert Stack.pop(pid) == "pink plate"
    assert Stack.pop(pid) == "blue plate"
    assert Stack.pop(pid) == "purple plate"
    assert Stack.pop(pid) == []
  end

  test "pop/1 - remove element from empty stack" do
    {:ok, pid} = Stack.start_link([])
    assert Stack.pop(pid) == []
  end

  test "push/2 - add element to empty stack" do
    {:ok, pid} = Stack.start_link([])
    Stack.push(pid, "pink plate")
    Process.sleep(500)
    assert :sys.get_state(pid) == ["pink plate"]
  end

  test "push/2 - add element to stack with multiple elements" do
    {:ok, pid} = Stack.start_link(["blue plate", "purple plate"])
    Stack.push(pid, "pink plate")
    Process.sleep(500)
    assert :sys.get_state(pid) == ["pink plate", "blue plate", "purple plate"]
  end
end
