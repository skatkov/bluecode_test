defmodule ApiServer.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, message(NumberServer.get))
  end

  post "/:numbers" do
    NumberServer.append(retrieve_list(numbers))

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, message(NumberServer.get))
  end

  delete "/" do
    NumberServer.clear

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, message([]))
  end

  get "/checksum" do
    case NumberServer.checksum do
      {:timeout, _} ->
        conn
          |> put_resp_content_type("application/json")
          |> send_resp(408, error('Timeout error'))
      result ->
        conn
          |> put_resp_content_type("application/json")
          |> send_resp(200, message(result))
      
    end
  end

  defp error(body) do
    Poison.encode!(%{
      status: "ERROR",
      body: body
    })
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