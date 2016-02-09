defmodule MediaWorks.Parser do
  alias MediaWorks.Product
  alias MediaWorks.ProductResponse
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

  def parse_products_response(%{result: result}) do
    parse_products_response(result)
  end

  def parse_products_response(%{prices: prices, product_part: product_part,
                                price_lists: price_lists, products: products}) do
    struct(ProductResponse, %{
      prices:        Enum.map(prices, &struct(Product.Price, &1)),
      product_parts: Enum.map(product_part, &struct(Product.Part, &1)),
      price_lists:   Enum.map(price_lists, &struct(Product.PriceList, &1)),
      products:      Enum.map(products, &struct(Product, &1))
    })
  end
end
