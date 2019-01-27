defmodule NumberServer do
	use GenServer

	# Client

	def start_link(_default) do
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

	def checksum do
		GenServer.call(__MODULE__, :checksum)
	end

	# Server callbacks

  def init(stack) do
    {:ok, stack}
  end

  def handle_call(:get, _from, store) do
    {:reply, store, store}
  end

  def handle_call(:checksum, _from, store) do
  	{:reply, get_checksum(store), store}
  end

  def handle_cast({:append, values}, store) do
  	{:noreply, store ++ values}
  end

  def handle_cast(:clear, _store) do
  	{:noreply, []}
  end


  def odd_items(list), do: list -- Enum.drop_every(list, 2)
  
  def odd_multiply(list), do: 3 * Enum.sum(odd_items(list))
  
  def even_sum(list), do: Enum.sum(Enum.drop_every(list, 2))
  
  def get_checksum(list) do
   result = (even_sum(list) + odd_multiply(list)) / 10

   result = round((result - round(result)) * 10)

   if result == 0 do
    result
   else
    10 - result
   end
 end
end