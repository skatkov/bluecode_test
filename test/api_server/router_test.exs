require IEx;

defmodule ApiServer.RouterTest do
  use ExUnit.Case, async: true
  use Plug.Test


  @opts ApiServer.Router.init([])

  test "get" do
    conn = conn(:get, "/")
    conn = ApiServer.Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert Poison.decode!(conn.resp_body)["status"] == "OK"
  end

  test 'clear' do
    conn = conn(:delete, "/")
    conn = ApiServer.Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert Poison.decode!(conn.resp_body)["status"] == "OK"
  end
end