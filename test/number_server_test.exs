defmodule ApiServer.NumberServerTest do
	use ExUnit.Case

  test "appends numbers" do
  	GenServer.start_link(NumberServer, [], name: NumberServer)
    NumberServer.clear

  	assert NumberServer.get == []
  	NumberServer.append([1, 2, 3])
  	assert NumberServer.get == [1, 2, 3]
  	NumberServer.append([9, 8, 7])
  	assert NumberServer.get == [1, 2, 3, 9, 8, 7]
  end

  test 'clean up state' do
  	GenServer.start_link(NumberServer, [], name: NumberServer)

  	NumberServer.append([1,2,3])
  	NumberServer.clear

  	assert NumberServer.get == []
  end


  test 'checksum' do
  	GenServer.start_link(NumberServer, [], name: NumberServer)
    NumberServer.clear

  	NumberServer.append([5, 4, 8, 9, 8, 5, 0, 3, 5, 4])

  	assert NumberServer.checksum() == 7
  end
end