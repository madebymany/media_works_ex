defmodule MediaWorks.Product do
  @type part_product :: {Part.t, Product.t} | {Part.t, nil}
  @type price_price_list :: {Price.t, PriceList.t} | {Price.t, nil}
  defstruct [:custom_params, :enabled, :expiration, :id, :JITLines,
            :label, :measure_unit, :modifier_qty_labels, :kernel_params,
            :product_code, :product_name, :product_priority,
            :production_settings, :product_type, :qty, :ShowOnKitchen]

  defmodule Price do
    defstruct [:added_unit_price, :computed,
              :included_qty, :default_unit_price,
              :product_code, :price_list,
              :subtracted_unit_price, :context, :id]
  end

  defmodule Part do
    defstruct [:id, :default_qty, :included_qty, :max_qty,
              :min_qty, :product_code, :part_code, :part_type]
  end

  defmodule PriceList do
    defstruct [:id, :menu_price_basis, :price_list_id]
  end

  @spec transform([Product.t], [Part.t], [PriceList.t], [Price.t]) :: [map]
  def transform(products, parts, price_lists, prices) do
    Enum.map(products, fn product ->
      parts =
        parts(product, parts)
        |> parts_with_products(products)

      prices =
        prices(product, prices)
        |> prices_with_price_lists(price_lists)

      %{product: product, parts: parts, prices: prices}
    end)
  end

  @spec parts(Product.t, [Part.t]) :: [Part.t]
  def parts(product, parts) do
    Enum.filter(parts, fn part ->
      part.part_code == product.product_code
    end)
  end

  @spec parts_with_products([Part.t], [Product.t]) :: [part_product]
  def parts_with_products(parts, products) do
    Enum.map(parts, &part_with_product(&1, products))
  end

  @spec part_with_product(Part.t, [Product.t]) :: part_product
  def part_with_product(part, products) do
    product = Enum.find(products, fn product ->
      product.product_code == part.product_code
    end)

    {part, product}
  end

  @spec prices(Product.t, [Price.t]) :: [Price.t]
  def prices(product, prices) do
    Enum.filter(prices, fn price ->
      price.product_code == product.product_code
    end)
  end

  @spec prices_with_price_lists([Price.t], [PriceList.t]) :: [price_price_list]
  def prices_with_price_lists(prices, price_lists) do
    Enum.map(prices, &price_with_price_list(&1, price_lists))
  end

  @spec price_with_price_list(Price.t, [PriceList.t]) :: price_price_list
  def price_with_price_list(price, price_lists) do
    price_list = Enum.filter(price_lists, fn price_list ->
      price_list.price_list_id == price.price_list
    end)

    {price, price_list}
  end
end
