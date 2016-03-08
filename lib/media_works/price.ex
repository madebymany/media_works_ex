defmodule MediaWorks.Price do
  defstruct price_list_id: nil,
            added_unit_price: nil,
            valid_thru: nil,
            subtracted_unit_price: nil,
            valid_from: nil,
            default_unit_price: nil,
            included_qty: nil,
            context: nil,
            product_code: nil,
            id: nil,
            computed: nil

  def new(response) do
    response =
      response
      |> Map.put(:computed, response[:computed] == 1)
      |> Map.put(:default_unit_price, parse_amount(response[:default_unit_price]))
      |> Map.put(:added_unit_price, parse_amount(response[:added_unit_price]))

    struct(__MODULE__, response)
  end

  defp parse_amount(nil), do: nil
  defp parse_amount(str) do
    {amt, _} = Float.parse(str)
    amt
  end
end
