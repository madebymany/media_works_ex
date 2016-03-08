defmodule MediaWorks.Order do
  alias MediaWorks.Utils
  defstruct order_id: nil,
            state_id: nil,
            state: nil,
            type_id: nil,
            type: nil,
            total_after_discount: nil,
            custom_order_properties: %{},
            total_amount: nil,
            total_gross: nil,
            total_tender: nil,
            due_amount: nil,
            discount_amount: nil,
            order_discount_amount: nil,
            tip: nil,
            business_period: nil,
            change: nil,
            originator_id: nil,
            pod_type: nil,
            price_basis: nil,
            sale_type: nil,
            sale_type_descr: nil,
            tenders: [],
            sale_lines: []

  def to_remote_order(%__MODULE__{} = order) do
    tenders =
      Map.get(order, :tenders, [])
      |> Enum.map(&Utils.filter_nils(&1))
      |> Utils.camelize_keys

    sale_lines =
      Map.get(order, :sale_lines, [])
      |> Enum.map(&Utils.filter_nils(&1))
      |> Utils.camelize_keys

    order =
      Map.from_struct(order)
      |> Map.drop([:tenders, :sale_lines])
      |> Utils.filter_nils
      |> Utils.camelize_keys

    %{order: order, saleLine: sale_lines, tender:  tenders}
  end
end
