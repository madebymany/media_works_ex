defmodule MediaWorks.API.HTTPClient do
  use HTTPotion.Base
  alias MediaWorks.Config
  @timeout (60 * 2) * 1000
  @remote_ordering "remote_ordering"
  @headers [
    "Accept": "application/json",
    "Content-Type": "application/json"
  ]

  def process_url(url) do
    case remote_ordering?(url)do
      true -> Config.remote_ordering_url <> url
      _ -> Config.api_url <> url
    end
  end

  def process_request_headers(custom_headers \\ []) do
    @headers ++ custom_headers
    |> Keyword.put(:"Authorization", "Basic: " <> Config.basic_auth)
    |> Keyword.put(:"X-API-Key", Config.api_key)
  end

  def process_request_body(body) when is_binary(body), do: body
  def process_request_body(body), do: Poison.encode!(body)

  def process_options(options \\ []) do
    options ++ [timeout: @timeout]
  end

  def process_response_body([] = body), do: body
  def process_response_body(body) do
    Poison.decode(body, keys: :atoms)
    |> case do
      {:ok, resp} -> resp
      {:error, _} -> %{desc: "Could not parse JSON response"}
    end
  end

  defp remote_ordering?(url), do: String.contains?(url, @remote_ordering)
end
