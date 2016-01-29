defmodule MediaWorks.Order do
  def to_xml(order),
    do: to_xml(order, [], [])

  def to_xml(order, tenders, sale_lines) do
    order(order, tenders, sale_lines)
    |> XmlBuilder.doc
  end

  defp order(order, tenders, sale_lines) do
    XmlBuilder.element :Order,
      camelize_keys(order),
      order_body(tenders, sale_lines)
  end

  defp order_body(tenders, sale_lines) do
    [tender_history(tenders), sale_lines(sale_lines)]
    |> Enum.filter(fn v -> v != nil end)
  end

  defp sale_lines(sale_lines)
    when is_map(sale_lines),
    do: sale_lines([sale_lines])

  defp sale_lines(sale_lines) do
    Enum.map(sale_lines, &sale_line(&1))
  end

  defp sale_line(sale_line) do
    XmlBuilder.element :SaleLine,
      camelize_keys(sale_line)
  end

  defp tender_history(tenders)
    when is_map(tenders),
    do: tender_history([tenders])

  defp tender_history(tenders) when length(tenders) > 0 do
    XmlBuilder.element :TenderHistory, %{},
      Enum.map(tenders, &tender(&1))
  end

  defp tender_history(tenders), do: nil

  defp tender(tender) do
    XmlBuilder.element :Tender,
      camelize_keys(tender)
  end

  defp camelize_keys(body) do
    Enum.map(body, fn {k, v} -> {camelize_key(k), v} end)
    |> Enum.into(%{})
  end

  defp camelize_key(key)
    when is_atom(key),
    do: camelize_key(to_string(key))

  defp camelize_key(key) do
    [h|t] = key |> Macro.camelize |> String.codepoints
    String.downcase(h) <> to_string(t)
  end
end
