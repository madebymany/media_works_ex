defmodule MediaWorks.API do
  @client Application.get_env(:media_works, :api_client, MediaWorks.API.HTTP)

  @callback get_stores() ::
    {:ok, [MediaWorks.Store.t]} | {:error, MediaWorks.Error.t}

  @callback get_store(store_id :: String.t) ::
    {:ok, MediaWorks.Store.t} | {:error, MediaWorks.Error.t}

  @callback get_products() ::
    {:ok, MediaWorks.ProductResponse.t} | {:error, MediaWorks.Error.t}

  @callback send_order(store_id :: String.t, map) ::
    {:ok, MediaWorks.SendOrderResponse.t} | {:error, MediaWorks.Error.t}

  defdelegate get_stores, to: @client
  defdelegate get_store(store_id), to: @client
  defdelegate get_products, to: @client

  def send_order(store_id, order) do
    order = order |> MediaWorks.Order.to_remote
    @client.send_order(store_id, order)
  end
end