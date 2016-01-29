defmodule MediaWorks.Config do
  def username do
    Application.get_env(:media_works, :username, System.get_env("MW_USERNAME"))
    |> check_value
  end

  def password do
    Application.get_env(:media_works, :password, System.get_env("MW_PASSWORD"))
    |> check_value
  end

  def api_key do
    Application.get_env(:media_works, :api_key, System.get_env("MW_API_KEY"))
    |> check_value
  end

  defp check_value(nil) do
    raise ArgumentError, message: "Invalid config value given"
  end

  defp check_value(value), do: value
end