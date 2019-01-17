defmodule NumberAgent do
  @moduledoc """
  	This is a simple adapter implmentation for persistant like storage
  """

  @doc """
  	Create a state pid
  """
  def new do
    Agent.start_link(fn -> [] end)
  end

  @doc """
  	Append List of number to existing state
  """
  def append(pid, list) do
    Agent.update(pid, fn state -> state ++ list end)
  end

  @doc """
    Drop all values
  """
  def clear(pid) do
    Agent.update(pid, fn _ -> _ = [] end)
  end

  @doc """
  	Retrieve all numbers stored in state
  """
  def get(pid) do
    Agent.get(pid, fn list -> list end)
  end
end