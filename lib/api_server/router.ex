defmodule ApiServer.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, message(["yeah", "baby", 11]))
  end

  post "/:numbers" do
    IO.puts numbers
    #%{agent: agent} = conn[:private]
    #IO.puts conn[:private]

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, message([]))
  end

  delete "/" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, message([]))
  end

  get "/checksum" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, message(["yeah", "baby", 333]))
  end

  defp message(body) do
    Poison.encode!(%{
      status: "OK",
      body: body
    })
  end
end