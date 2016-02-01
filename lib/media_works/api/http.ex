defmodule MediaWorks.API.HTTP do
  @behaviour MediaWorks.API
  alias MediaWorks.API.HTTPClient
  alias MediaWorks.Parser

  def get_stores do
    HTTPClient.post("/api/data/export_store")
    |> Parser.parse_server_response
    |> case do
      {:ok, body} ->
        {:ok, Parser.parse_stores_response(body)}
      err -> err
    end
  end

  def get_store(store_id) do
    HTTPClient.post("/api/data/export_store" <> to_string(store_id))
    |> Parser.parse_server_response
    |> case do
      {:ok, body} ->
        {:ok, List.first(Parser.parse_stores_response(body))}
      err -> err
    end
  end

  def get_products do
    HTTPClient.post("/api/data/export_product")
    |> Parser.parse_server_response
    |> case do
      {:ok, body} ->
        {:ok, Parser.parse_products_response(body)}
      err -> err
    end
  end

  def send_order(store_id, order) do
    HTTPClient.post("/api/remote_ordering/" <> to_string(store_id), [body: order])
    |> Parser.parse_server_response
    |> Parser.parse_send_order_response
    |> case do
      {:ok, resp} -> {:ok, resp}
      err -> err
    end
  end
end