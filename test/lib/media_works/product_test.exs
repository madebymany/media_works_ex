defmodule MediaWorks.ProductTest do
  use ExUnit.Case
  alias MediaWorks.Product

  test "can parse product tags" do
    data = %{
      product_tags: [
        "Modifier=One",
        "Modifier=Two",
        "SomethingElse=Three"
      ],
      kernel_params: %{}
    }

    expected = %{
      modifier: ["One", "Two"],
      something_else: ["Three"]
    }

    actual = Product.new(data)
    assert actual.product_tags == expected
  end
end
