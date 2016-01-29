defmodule MediaWorksApiTest do
  use ExUnit.Case

  test "#stores returns all the stores" do
    {result, body} = MediaWorks.API.stores

    assert result == :ok
    assert is_list(body.result)
  end

  test "#store(store_id) returns the store that it finds" do
    {result, body} = MediaWorks.API.store("1")

    assert result == :ok
    assert is_map(body.result)
  end

  test "#store(store_id) returns errors when it cant find a store" do
    {result, body} = MediaWorks.API.store("2")

    assert result == :error
    assert is_binary(body.desc)
  end

  test "#orders(store_id) returns errors when it cant find the store" do
    {result, body} = MediaWorks.API.orders("2")

    assert result == :error
    assert is_binary(body.desc)
  end

  test "#send_order(store_id, order) returns errors when it gets passed invalid Order" do
    {result, body} = MediaWorks.API.send_order("2", "BadBody")

    assert result == :error
    assert is_binary(body.desc)
  end

  test "#send_order(store_id, order) returns errors when it cant find the store" do
    {result, body} = MediaWorks.API.send_order("2", "BadBody")

    assert result == :error
    assert is_binary(body.desc)
  end
end
