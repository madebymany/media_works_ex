defmodule MediaWorksHttpTest do
  use ExUnit.Case
  alias MediaWorks.HTTP, as: Subject

  test "#process_url(url) processes the url" do
    url = "hello/there"
    expected_url = "https://mw-central.appspot.com/hello/there"

    assert Subject.process_url(url) == expected_url
  end

  test "#process_request_headers(headers) adds headers to the request" do
    custom_headers = ["Hello": "World"]
    expected_output = ["X-API-Key": "asdf",
      Authorization: "Basic: YXNkZjphc2Rm",
      Accept: "application/json",
      "Content-Type": "application/xml",
      Hello: "World"]

    assert Subject.process_request_headers(custom_headers) == expected_output
  end

  test "#process_request_headers(headers) leaves headers alone if nothing is given" do
    expected_output = ["X-API-Key": "asdf",
      Authorization: "Basic: YXNkZjphc2Rm",
      Accept: "application/json",
      "Content-Type": "application/xml"]

    assert Subject.process_request_headers == expected_output
  end

  test "#process_response_body(body) returns an empty array if it body is empty" do
    body = []

    assert Subject.process_response_body(body) == body
  end

  test "#process_response_body(body) returns the body on a successful request" do
    body = "{ \"body\": \"result\"}"

    assert Subject.process_response_body(body) == %{body: "result"}
  end

  test "#process_response_body(body) returns an error on an unsuccessful request" do
    body = "{body: \"something\"}"

    assert Subject.process_response_body(body) == %{desc: "Could not parse JSON response"}
  end
end
