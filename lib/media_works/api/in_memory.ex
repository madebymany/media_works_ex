defmodule MediaWorks.API.InMemory do
  @behaviour MediaWorks.API
  alias MediaWorks.{Store, ProductResponse, Price, PriceList, Product, SendOrderResponse, Error}

  def get_stores do
    {:ok, [%Store{id: "1234", store_id: "1", name: "Dummy store #1"},
           %Store{id: "2345", store_id: "2", name: "Dummy store #2"}]}
  end

  def get_store(_store_id) do
    {:ok, %Store{id: "1234", store_id: "1", name: "Dummy store #1"}}
  end

  def get_products(_store_id) do
    {:ok, %ProductResponse{
      products: [%Product{}],
      product_classifications: [%Product.Classification{}],
      price_lists: [%PriceList{}],
      product_parts: [%Product.Part{}],
    }}
  end

  def send_order(_store_id, %{order: %{orderId: 100000}}) do
    {:ok, %SendOrderResponse{code: 0, desc: "Sent"}}
  end

  def send_order(_store_id, %{order: %{orderId: 100001}}) do
    {:error, %Error{message: "Out of working hours"}}
  end
end
