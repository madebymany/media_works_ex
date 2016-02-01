defmodule MediaWorks.ProductTest do
  use ExUnit.Case
  alias MediaWorks.Product

  test "#part_with_product will return a correctly matched tuple of {part, product}" do
    product = %Product{product_code: "1234"}
    part = %Product.Part{product_code: "1234"}

    assert Product.part_with_product(part, [product]) == {part, product}
  end

  test "#parts_with_products will return an array of correctly matched {part, product} tuples" do
    product = %Product{product_code: "1234"}
    part = %Product.Part{product_code: "1234"}

    [result | _] = Product.parts_with_products([part], [product])
    assert result == {part, product}
  end

  test "#parts will return an array of all parts for the product" do
    product = %Product{product_code: "1234"}
    parts = [
      %Product.Part{part_code: "1234"},
      %Product.Part{part_code: "1234"}
    ]

    assert Product.parts(product, parts) == parts
  end

  test "#transform will work?" do
    product = %Product{product_code: "1234"}
    product_part = %Product{product_code: "2345"}

    parts = [
      %Product.Part{part_code: "1234", product_code: "2345"}
    ]

    prices = [
      %Product.Price{price_list: "123",product_code: "1234"}
    ]

    price_lists = [
      %Product.PriceList{price_list_id: "123"}
    ]

    expected = Product.transform([product, product_part], parts, price_lists, prices)
    IO.inspect expected
  end

end