defmodule MediaWorks.Parser do
  alias MediaWorks.Error
  alias MediaWorks.Store
  alias MediaWorks.SendOrderResponse

  def parse_server_response(%{body: body, status_code: status_code})
    when status_code < 400 do
    {:ok, Map.put(body, :status_code, status_code)}
  end

  def parse_server_response(resp) do
    {:error, Error.from_server_response(resp)}
  end

  def parse_send_order_response({:error, _error} = resp), do: resp
  def parse_send_order_response({:ok, body}) do
    order_response = struct(SendOrderResponse, body)

    if SendOrderResponse.success?(order_response) do
      {:ok, order_response}
    else
      {:error, Error.from_send_order_response(order_response)}
    end
  end

  def parse_stores_response(%{result: result}) do
    parse_stores_response(result)
  end

  def parse_stores_response(stores) when is_list(stores) do
    Enum.map(stores, &struct(Store, &1))
  end
end
