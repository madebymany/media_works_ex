defmodule MediaWorks.API.HTTPClient do
  use HTTPotion.Base
  alias MediaWorks.Config
  @api_url "https://mw-central.appspot.com/"
  @headers ["Accept": "application/json",
            "Content-Type": "application/json"]

  def process_url(url) do
    @api_url <> url
  end

  def process_request_headers(custom_headers \\ []) do
    @headers ++ custom_headers
    |> Keyword.put(:"Authorization", "Basic: #{basic_auth_header}")
    |> Keyword.put(:"X-API-Key", Config.api_key)
  end

  def process_request_body(body), do: Poison.encode!(body)

  def process_response_body([] = body), do: body
  def process_response_body(body) do
    Poison.decode(body, keys: :atoms)
    |> case do
      {:ok, resp} -> resp
      {:error, _} -> %{desc: "Could not parse JSON response"}
    end
  end

  defp basic_auth_header do
    :base64.encode_to_string("#{Config.username}:#{Config.password}")
  end
end
