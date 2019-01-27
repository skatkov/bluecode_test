require IEx;

defmodule ApiServer.RouterTest do
  use ExUnit.Case, async: true
  use Plug.Test


  @opts ApiServer.Router.init([])

  test "get" do
    NumberServer.start_link([])
    NumberServer.clear

    conn = conn(:get, "/")
    conn = ApiServer.Router.call(conn, @opts)
    body = Poison.decode!(conn.resp_body)

    assert conn.state == :sent
    assert conn.status == 200
    assert body["status"] == "OK"
    assert body["body"] == []
  end

  test 'post' do
    NumberServer.start_link([])
    
    conn = conn(:post, "/123")
    conn = ApiServer.Router.call(conn, @opts)
    body = Poison.decode!(conn.resp_body)

    assert conn.state == :sent
    assert conn.status == 200
    assert body["status"] == "OK"
    assert body["body"] == [1,2,3]

    conn = conn(:post, "/876")
    conn = ApiServer.Router.call(conn, @opts)

    assert Poison.decode!(conn.resp_body)["body"] == [1,2,3,8,7,6]
  end

  test "checksum" do
    NumberServer.start_link([])

    
    ApiServer.Router.call(conn(:post, "/123"), @opts)

    conn = conn(:get, "/checksum")
    conn = ApiServer.Router.call(conn, @opts)
    body = Poison.decode!(conn.resp_body)

    assert conn.status == 200
    assert body["status"] == "OK"
    assert body["body"] == 6
  end

  test 'clear' do
    NumberServer.start_link([])

    conn = conn(:post, "/123")
    conn = ApiServer.Router.call(conn, @opts)
    assert conn.status == 200

    conn = conn(:delete, "/")
    conn = ApiServer.Router.call(conn, @opts)
    body = Poison.decode!(conn.resp_body)

    assert conn.state == :sent
    assert conn.status == 200
    assert body["status"] == "OK"
    assert body["body"] == []
  end
end