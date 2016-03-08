defmodule MediaWorks.Utils do
  def filter_nils(item) do
    item
    |> Enum.filter(fn {_, v} -> v != nil end)
    |> Enum.into(%{})
  end

  @spec camelize_keys(list) :: list
  def camelize_keys(item) when is_list(item) do
    Enum.map(item, &camelize_keys(&1))
  end

  @spec camelize_keys(map) :: map
  def camelize_keys(item) when is_map(item) do
    Enum.map(item, fn item ->
      camelize_keys(item)
    end) |> Enum.into(%{})
  end

  @spec camelize_keys(tuple) :: tuple
  def camelize_keys({ key, value }) when is_map(value) do
    {camelize(key), camelize_keys(value)}
  end

  def camelize_keys({ key, value }) when is_list(value) do
    {camelize(key), Enum.map(value, &camelize_keys(&1))}
  end

  def camelize_keys({ key, value }) do
    {camelize(key), value}
  end

  @spec underscore_keys(list) :: list
  def underscore_keys(item) when is_list(item) do
    Enum.map(item, &underscore_keys(&1))
  end

  @spec underscore_keys(map) :: map
  def underscore_keys(item) when is_map(item) do
    Enum.map(item, fn item ->
      underscore_keys(item)
    end) |> Enum.into(%{})
  end

  @spec underscore_keys(tuple) :: tuple
  def underscore_keys({ key, value }) when is_map(value) do
    {underscore(key), underscore_keys(value)}
  end

  def underscore_keys({ key, value }) when is_list(value) do
    {underscore(key), Enum.map(value, &underscore_keys(&1))}
  end

  def underscore_keys({ key, value }) do
    {underscore(key), value}
  end

  @spec underscore(atom) :: atom
  def underscore(item) when is_atom(item) do
    item |> to_string |> underscore |> String.to_atom
  end

  @spec underscore(String.t) :: String.t

  def underscore(""), do: ""

  def underscore(<<h, t :: binary>>) do
    <<to_lower_char(h)>> <> do_underscore(t, h)
  end

  defp do_underscore(<<h, t, rest :: binary>>, _) when h in ?A..?Z and not (t in ?A..?Z or t == ?.) do
    <<?_, to_lower_char(h), t>> <> do_underscore(rest, t)
  end

  defp do_underscore(<<h, t :: binary>>, prev) when h in ?A..?Z and not prev in ?A..?Z do
    <<?_, to_lower_char(h)>> <> do_underscore(t, h)
  end

  defp do_underscore(<<?., t :: binary>>, _) do
    <<?/>> <> underscore(t)
  end

  defp do_underscore(<<h, t :: binary>>, _) do
    <<to_lower_char(h)>> <> do_underscore(t, h)
  end

  defp do_underscore(<<>>, _) do
    <<>>
  end

  defp to_lower_char(char) when char in ?A..?Z, do: char + 32
  defp to_lower_char(char), do: char

  @spec camelize(atom) :: atom
  def camelize(item) when is_atom(item) do
    item |> to_string |> camelize |> String.to_atom
  end

  @spec camelize(String.t) :: String.t
  def camelize(""), do: ""

  def camelize(<<?_, t :: binary>>) do
    camelize(t)
  end

  def camelize(<<h, t :: binary>>) do
    <<to_lower_char(h)>> <> do_camelize(t)
  end

  defp do_camelize(<<?_, ?_, t :: binary>>) do
    do_camelize(<< ?_, t :: binary >>)
  end

  defp do_camelize(<<?_, h, t :: binary>>) when h in ?a..?z do
    <<to_upper_char(h)>> <> do_camelize(t)
  end

  defp do_camelize(<<?_>>) do
    <<>>
  end

  defp do_camelize(<<?/, t :: binary>>) do
    <<?.>> <> camelize(t)
  end

  defp do_camelize(<<h, t :: binary>>) do
    <<h>> <> do_camelize(t)
  end

  defp do_camelize(<<>>) do
    <<>>
  end

  defp to_upper_char(char) when char in ?a..?z, do: char - 32
  defp to_upper_char(char), do: char
end