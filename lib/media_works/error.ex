defmodule MediaWorks.Error do
  defstruct status_code: nil,
            message: "An error occurred",
            metadata: %{}

  def from_server_response(%{body: %{desc: desc} = body, status_code: status_code}) do
    struct(__MODULE__, %{message: desc,
                         status_code: status_code,
                         metadata: %{body: body}})
  end

  def from_server_response(%{body: body, status_code: status_code}) do
    struct(__MODULE__, %{status_code: status_code,  metadata: %{body: body}})
  end

  def from_send_order_response(%{desc: desc, code: code} = body) do
    struct(__MODULE__, %{status_code: 200,
                         message: desc,
                         metadata: Map.from_struct(body)})
  end
end