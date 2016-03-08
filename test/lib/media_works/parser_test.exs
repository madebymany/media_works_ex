defmodule MediaWorks.ParserTest do
  use ExUnit.Case
  alias MediaWorks.Parser, as: Subject

  test "#parse_server_response returns :ok tuple for a 200 response" do
    response = %{status_code: 200, body: %{foo: "bar"}}
    {status, body} = Subject.parse_server_response(response)

    assert status == :ok
    assert body == %{foo: "bar", status_code: 200}
  end

  test "#parse_server_response returns :error tuple for a 404 response" do
    response = %{status_code: 404, body: %{foo: "bar"}}
    {status, body} = Subject.parse_server_response(response)

    assert status == :error
    assert body.__struct__ == MediaWorks.Error
  end

  test "#parse_remote_order_response will return a RemoteOrderResponse struct" do
    response = %{code: 0, desc: "testing"}
    {_, parsed} = Subject.parse_send_order_response({:ok, response})

    assert parsed.__struct__ == MediaWorks.SendOrderResponse
  end

  test "#parse_stores_response will return a list of Store structs" do
    response = [%{id: 1, name: "My store"}]
    parsed = Subject.parse_stores_response(response)

    Enum.each(parsed, fn item ->
      assert item.__struct__ == MediaWorks.Store
    end)
  end
end