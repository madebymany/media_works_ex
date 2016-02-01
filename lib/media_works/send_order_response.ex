defmodule MediaWorks.SendOrderResponse do
  defstruct [:code, :desc]
  @valid_response_codes [0, 2]

  def success?(%{code: code}) when code in @valid_response_codes, do: true
  def success?(%{code: code}), do: false
end