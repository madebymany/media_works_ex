defmodule MediaWorks.API.HTTPClientTest do
  use ExUnit.Case
  alias MediaWorks.API.HTTPClient

  test "#process_url(url) processes the url" do
    url = "hello/there"
    expected_url = "https://mw-central.appspot.com/hello/there"

    assert HTTPClient.process_url(url) == expected_url
  end

  test "#process_url(url) expects a different url for remote_ordering endpoint" do
    url = "hello/remote_ordering"
    expected_url = "https://remote-ordering-dot-mw-central.appspot.com/hello/remote_ordering"

    assert HTTPClient.process_url(url) == expected_url
  end

  test "#process_request_headers(headers) adds headers to the request" do
    custom_headers = ["Hello": "World"]
    expected_output = ["X-API-Key": "asdf",
      Authorization: "Basic: asdf",
      Accept: "application/json",
      "Content-Type": "application/json",
      Hello: "World"]

    assert HTTPClient.process_request_headers(custom_headers) == expected_output
  end

  test "#process_request_headers(headers) leaves headers alone if nothing is given" do
    expected_output = ["X-API-Key": "asdf",
      Authorization: "Basic: asdf",
      Accept: "application/json",
      "Content-Type": "application/json"]

    assert HTTPClient.process_request_headers == expected_output
  end

  test "#process_response_body(body) returns an empty array if it body is empty" do
    body = []

    assert HTTPClient.process_response_body(body) == body
  end

  test "#process_response_body(body) returns the body on a successful request" do
    body = "{ \"body\": \"result\"}"

    assert HTTPClient.process_response_body(body) == %{body: "result"}
  end

  test "#process_response_body(body) returns an error on an unsuccessful request" do
    body = "{body: \"something\"}"

    assert HTTPClient.process_response_body(body) == %{desc: "Could not parse JSON response"}
  end
end
