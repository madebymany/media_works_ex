defmodule MediaWorks.ProductParserTest do
  use ExUnit.Case
  alias MediaWorks.{ProductParser, Product, PriceList, Price}

  setup do
    {:ok, binary} = File.read("test/fixtures/mw_products_response.json")
    {:ok, json} = Poison.decode(binary, keys: :atoms)

    {:ok, result: json.result}
  end

  test "can parse a full JSON response", %{result: result} do
    result = ProductParser.parse(result)

    assert length(result.products) > 0
    assert length(result.product_classifications) > 0
    assert length(result.price_lists) > 0
    assert length(result.product_parts) > 0
  end

  test "parse_price_lists will return a list of price lists with corresponding prices", %{result: result} do
    [price_list | _] = ProductParser.parse_price_lists(result.price_lists, result.prices)

    assert price_list.__struct__ == PriceList
    assert length(price_list.prices) > 0
    assert List.first(price_list.prices).__struct__ == Price
  end

  test "can parse and normalize product_classifications" do
    given = [%{
      product_code: %{product_code: "1234"},
      class_code: %{product_code: "1234"},
      id: "1234"
    }]

    expected = [%Product.Classification{
      product_code: "1234",
      id: "1234",
      class_code: "1234"
    }]

    assert expected == ProductParser.parse_product_classifications(given)
  end

end
