defmodule MediaWorks.API do
  @valid_order_codes [0, 2]
  @http Application.get_env(:media_works, :mw_api)

  def stores do
    @http.post("/api/data/export_store")
    |> parse_response
  end

  def store(store_id) do
    @http.post("/api/data/export_store/" <> to_string(store_id))
    |> parse_response
  end

  def products do
    @http.post("/api/data/export_product")
    |> parse_response
  end

  def orders(store_id) do
    @http.post("/api/data/export_orders/" <> to_string(store_id))
    |> parse_response
  end

  def send_order(store_id, order) do
    @http.post("/api/remote_ordering/" <> to_string(store_id), [body: order])
    |> parse_response
  end

  defp parse_response(%{body: %{code: code} = body, status_code: status_code})
    when code in @valid_order_codes,
    do: {:ok, body_with_status_code(body, status_code)}

  defp parse_response(%{body: %{code: _code} = body, status_code: status_code}),
    do: {:error, body_with_status_code(body, status_code)}

  defp parse_response(%{body: body, status_code: status_code})
    when status_code < 400,
    do: {:ok, body_with_status_code(body, status_code)}

  defp parse_response(%{body: body, status_code: status_code}),
    do: {:error, body_with_status_code(body, status_code)}

  defp body_with_status_code(body, status_code) do
    body |> Map.put(:status_code, status_code)
  end
end
