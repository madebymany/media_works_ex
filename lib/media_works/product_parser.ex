defmodule MediaWorks.ProductParser do
  alias MediaWorks.{Product, ProductResponse, PriceList, Price}
  alias MediaWorks.Product.{Classification, Part}

  def parse(%{products: products,
              prices: prices,
              product_parts: product_parts,
              price_lists: price_lists,
              products: products,
              product_classifications: product_classifications,
              order_modes: _,}) do
    %ProductResponse{
      products: parse_products(products),
      product_classifications: parse_product_classifications(product_classifications),
      product_parts: parse_product_parts(product_parts),
      price_lists: parse_price_lists(price_lists, prices)
    }
  end

  @spec parse_products([map]) :: [Product.t]
  def parse_products(products) do
    Enum.map(products, fn product -> Product.new(product) end)
  end

  @spec parse_product_parts([map]) :: [Part.t]
  def parse_product_parts(product_parts) do
    Enum.map(product_parts, fn pp -> struct(Part, pp) end)
  end

  @spec parse_price_lists([map], [map]) :: [PriceList.t]
  def parse_price_lists(price_lists, prices) do
    Enum.map(price_lists, &parse_price_list(&1, prices))
  end

  @spec parse_price_list(map, [map]) :: PriceList.t
  def parse_price_list(price_list, prices) do
    prices =
      prices
      |> Enum.filter(fn p -> p[:price_list_id] == price_list[:price_list_id] end)
      |> Enum.map(fn p -> Price.new(p) end)

    struct(PriceList, Map.put(price_list, :prices, prices))
  end

  @spec parse_product_classifications([map]) :: [Classification.t]
  def parse_product_classifications(product_classifications) do
    Enum.map(product_classifications, fn %{product_code: pc, class_code: cc, id: id} ->
      struct(Classification, %{id: id, product_code: pc[:product_code], class_code: cc[:product_code]})
    end)
  end
end
