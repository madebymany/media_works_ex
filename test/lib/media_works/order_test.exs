defmodule MediaWorksOrderTest do
  use ExUnit.Case
  alias MediaWorks.Order, as: Subject

  test "#to_xml(order) writes xml for an order" do
    order = %{some: "thing"}
    expectation = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n<Order some=\"thing\">\n\n</Order>"
    output = Subject.to_xml(order)

    assert output == expectation
  end

  test "#to_xml(order, tenders, sale_lines) writes xml for an order" do
    order = %{some: "thing"}
    tenders = %{other: "thing"}
    sale_lines = %{the_other: "thing"}

    expectation = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>" <>
    "\n<Order some=\"thing\">" <>
    "\n\t<TenderHistory>\n\t\t" <>
    "<Tender other=\"thing\"/>\n\t" <>
    "</TenderHistory>\n\t" <>
    "<SaleLine theOther=\"thing\"/>\n</Order>"

    output = Subject.to_xml(order, tenders, sale_lines)

    assert output == expectation
  end

  test "#to_xml(orders, tenders, sale_lines) writes xml without tender history" do
    order = %{some: "thing"}
    tenders = []
    sale_lines = %{the_other: "thing"}

    expectation = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>" <>
    "\n<Order some=\"thing\">\n\t" <>
    "<SaleLine theOther=\"thing\"/>\n</Order>"

    output = Subject.to_xml(order, tenders, sale_lines)

    assert output == expectation
  end
end
