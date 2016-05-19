defmodule MediaWorks.API.HTTP do
  @behaviour MediaWorks.API
  alias MediaWorks.API.HTTPClient
  alias MediaWorks.{Parser, ProductParser}

  @timeout 30_000

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

  def get_products(store_id) do
    HTTPClient.post("/api/data/export_product" <> to_string(store_id), [timeout: @timeout])
    |> Parser.parse_server_response
    |> case do
      {:ok, body} ->
        {:ok, ProductParser.parse(body.result)}
      err -> err
    end
  end

  def get_datapump(params), do: do_datapump_request(params)
  def get_datapump(store_id, start_timestamp) do
    do_datapump_request(%{"store_id" => store_id, "start_timestamp" => start_timestamp})
  end

  def do_datapump_request(%{"store_id" => store_id} = params) do
    HTTPClient.get("/api/datapumps/?" <> URI.encode_query(params))
    |> Parser.parse_server_response
    |> case do
      {:ok, body} ->
        {:ok, Parser.parse_datapump_response(store_id, body)}
      err -> err
    end
  end

  def send_order(store_id, order) do
    HTTPClient.post("/api/remote_ordering/" <> to_string(store_id), [body: order, timeout: @timeout])
    |> Parser.parse_server_response
    |> Parser.parse_send_order_response
  end
end
