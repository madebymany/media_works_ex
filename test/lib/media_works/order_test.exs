defmodule MediaWorks.OrderTest do
  use ExUnit.Case
  alias MediaWorks.Order

  test "#to_remote_order will drop nil values from order" do
    order = %Order{
      order_id: nil,
      state: "PAID"
    }

    %{order: remote_order} = Order.to_remote_order(order)
    refute Map.has_key?(remote_order, :orderId)
  end

  test "#to_remote_order will drop nil values from tenders" do
    order = %Order{
      tenders: [%{
        tender_id: "1",
        tender_type: nil
      }]
    }

    %{tender: tenders} = Order.to_remote_order(order)
    refute Map.has_key?(List.first(tenders), :tenderType)
  end

  test "#to_remote_order will drop nil values from sale_lines" do
    order = %Order{
      sale_lines: [%{
        id: nil,
        product_code: "1234"
      }]
    }

    %{saleLine: sale_lines} = Order.to_remote_order(order)
    refute Map.has_key?(List.first(sale_lines), :id)
  end

end
