defmodule ApiServer.NumberServerTest do
	use ExUnit.Case

  test "appends numbers" do
  	{:ok, _} = GenServer.start_link(ApiServer.NumberServer, [], name: ApiServer.NumberServer)

  	assert ApiServer.NumberServer.get == []
  	ApiServer.NumberServer.append([1, 2, 3])
  	assert ApiServer.NumberServer.get == [1, 2, 3]
  	ApiServer.NumberServer.append([9, 8, 7])
  	assert ApiServer.NumberServer.get == [1, 2, 3, 9, 8, 7]
  end

  test 'clean up state' do
  	{:ok, _} = GenServer.start_link(ApiServer.NumberServer, [], name: ApiServer.NumberServer)

  	ApiServer.NumberServer.append([1,2,3])
  	ApiServer.NumberServer.clear

  	assert ApiServer.NumberServer.get == []
  end
end