defmodule MediaWorks.API do
  @client Application.get_env(:media_works, :api_client, MediaWorks.API.HTTP)

  @callback get_stores() ::
    {:ok, [MediaWorks.Store.t]} | {:error, MediaWorks.Error.t}

  @callback get_store(store_id :: String.t) ::
    {:ok, MediaWorks.Store.t} | {:error, MediaWorks.Error.t}

  @callback get_products(store_id :: String.t) ::
    {:ok, MediaWorks.ProductResponse.t} | {:error, MediaWorks.Error.t}

  @callback send_order(store_id :: String.t, order :: MediaWorks.Order.t | map) ::
    {:ok, MediaWorks.SendOrderResponse.t} | {:error, MediaWorks.Error.t}

  @callback get_datapump(datapump :: MediaWorks.DatapumpResponse.t) ::
    {:ok, MediaWorks.DatapumpResponse.t} | {:error, MediaWorks.Error.t}

  @callback get_datapump(params :: map) ::
    {:ok, MediaWorks.DatapumpResponse.t} | {:error, MediaWorks.Error.t}

  @callback get_datapump(store_id :: String.t, start_timestamp :: String.t) ::
    {:ok, MediaWorks.DatapumpResponse.t} | {:error, MediaWorks.Error.t}

  defdelegate get_stores, to: @client
  defdelegate get_store(store_id), to: @client
  defdelegate get_products(store_id), to: @client
  defdelegate get_datapump(store_id, start_timestamp), to: @client
  def get_datapump(%MediaWorks.DatapumpResponse{} = datapump) do
    [_ | next_params] =
      datapump.next_url
      |> String.split("&")

    URI.decode_query(next_params)
    |> @client.get_datapump
  end
  defdelegate get_datapump(params), to: @client

  def send_order(store_id, %MediaWorks.Order{} = order) do
    order = order |> MediaWorks.Order.to_remote
    @client.send_order(store_id, order)
  end

  def send_order(store_id, order) do
    @client.send_order(store_id, order)
  end

end
