defmodule MediaWorks.Product do
  defstruct enabled: nil,
            custom_params: nil,
            availability_len: nil,
            product_name: nil,
            kernel_params: %{},
            modifier_qty_labels: [],
            production_settings: nil,
            product_code: nil,
            id: nil,
            product_type: nil,
            product_priority: 100,
            product_tags: []

  def new(%{kernel_params: kernel_params} = response) do
    response =
      response
      |> Map.put(:enabled, kernel_params[:enabled] == 1)
      |> Map.put(:product_priority, kernel_params[:product_priority])
      |> Map.put(:product_type, kernel_params[:product_type])
      |> Map.put(:product_tags, parse_product_tags(response[:product_tags]))
      |> Map.put(:kernel_params, Map.drop(kernel_params, [:enabled, :product_priority, :product_type]))

    struct(__MODULE__, response)
  end

  defp parse_product_tags(tags) do
    Enum.reduce(tags, %{}, fn tag, acc ->
      [tag_name | tag_list] = String.split(tag, "=")
      tag_name = MediaWorks.Utils.underscore(tag_name) |> String.to_atom

      if Map.has_key?(acc, tag_name) do
        tag_list = acc[tag_name] ++ tag_list
      end

      Map.put(acc, tag_name, tag_list)
    end)
  end
end
