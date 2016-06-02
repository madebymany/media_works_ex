defmodule MediaWorks.SendOrderResponse do
  defstruct [:code, :desc, :pos_order_id]
  @valid_response_codes [0, 2]

  def success?(%{code: code}) when code in @valid_response_codes, do: true
  def success?(%{code: code}), do: false
end
