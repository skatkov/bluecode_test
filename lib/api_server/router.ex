defmodule ApiServer.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, message(ApiServer.NumberServer.get))
  end

  post "/:numbers" do
    ApiServer.NumberServer.append(retrieve_list(numbers))

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, message(ApiServer.NumberServer.get))
  end

  delete "/" do
    ApiServer.NumberServer.clear

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, message(ApiServer.NumberServer.get))
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

  defp retrieve_list(string) do
    String.splitter("#{string}", "", trim: true)
    |> Enum.map(fn x -> String.to_integer(x) end)
    |> Enum.to_list
  end
end