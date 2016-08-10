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

  def basic_auth do
    Application.get_env(:media_works, :basic_auth, System.get_env("MW_BASIC_AUTH"))
    |> check_value
  end

  def remote_ordering_sessions do
    Application.get_env(:media_works, :remote_ordering_sessions)
  end

  def remote_ordering_pipeline do
    Application.get_env(:media_works, :remote_ordering_pipeline)
  end

  def remote_ordering_url do
    Application.get_env(:media_works, :remote_ordering_url)
  end

  def api_url do
    Application.get_env(:media_works, :api_url)
  end

  defp check_value(nil) do
    raise ArgumentError, message: "Invalid config value given"
  end

  defp check_value(value), do: value
end
