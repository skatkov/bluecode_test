defmodule NumberAgentTest do
  use ExUnit.Case
  doctest NumberAgent

  test "appends numbers" do
    {:ok, agent} = NumberAgent.new()
    assert NumberAgent.get(agent) == []

    NumberAgent.append(agent, [1, 2, 3])
    assert NumberAgent.get(agent) == [1, 2, 3]
    NumberAgent.append(agent, [9, 8, 7])
    assert NumberAgent.get(agent) == [1, 2, 3, 9, 8, 7]
  end

  test 'clean up state' do
    {:ok, agent} = NumberAgent.new()
    NumberAgent.append(agent, [1, 2, 3])
    NumberAgent.clear(agent)
    assert NumberAgent.get(agent) == []
  end
end
