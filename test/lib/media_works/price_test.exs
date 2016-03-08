defmodule MediaWorks.PriceTest do
  use ExUnit.Case
  alias MediaWorks.Price

  test "will correctly coerce price properties" do
    response = %{
      computed: 0,
      default_unit_price: "2.75"
    }

    actual = Price.new(response)

    assert actual.computed == false
    assert actual.default_unit_price == 2.75
  end
end
