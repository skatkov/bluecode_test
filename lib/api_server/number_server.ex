defmodule ApiServer.NumberServer do
	use GenServer

	# Client

	def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def get do
  	GenServer.call(__MODULE__, :get)
	end

	def append(value) do
		GenServer.cast(__MODULE__, {:append, value})
	end

	def clear do
		GenServer.cast(__MODULE__, :clear)
	end

	# Server callbacks

  def init(stack) do
    {:ok, stack}
  end

  def handle_call(:get, _from, store) do
    {:reply, store, store}
  end

  def handle_cast({:append, values}, store) do
  	{:noreply, store ++ values}
  end

  def handle_cast(:clear, _store) do
  	{:noreply, []}
  end
end