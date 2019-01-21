defmodule ApiServer.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(message(["yeah", "baby", 11])))
  end

  put "/:numbers" do
    IO.puts numbers
    #%{agent: agent} = conn[:private]
    IO.puts conn[:private]

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(message(["yeah", "baby", 222])))
  end

  get "/checksum" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(message(["yeah", "baby", 333])))
  end

  defp message(body) do
    %{
      status: "OK",
      body: body
    }
  end
end