defmodule UnicodeChecker do
  @moduledoc """
  Checks byte sequences for unicode validity
  """

  @doc """
  Method 1: Returns true if the given byte sequence is valid unicode. False,
  otherwise.

  ## Examples

    iex> <<197, 130, 1>> |> UnicodeChecker.valid?()
    true

    iex> <<235, 140, 4>> |> UnicodeChecker.valid?()
    false

  """
  @spec valid?(binary) :: boolean
  def valid?(<<front, rest::binary>>) do
    case to_bin(front) do
      "0" <> _ ->
        valid?(rest)

      "11110" <> _ ->
        <<a, b, c, the_rest::binary>> = rest
        valid_sub_bytes([a, b, c]) and valid?(the_rest)

      "1110" <> _ ->
        <<a, b, the_rest::binary>> = rest
        valid_sub_bytes([a, b]) and valid?(the_rest)

      "110" <> _ ->
        <<a, the_rest::binary>> = rest
        valid_sub_bytes([a]) and valid?(the_rest)
    end
  end

  def valid?(<<>>), do: true

  def valid?(_), do: false

  defp valid_sub_bytes(list) do
    Enum.reduce_while(list, true, fn x, _acc ->
      if "10" == x |> to_bin() |> String.slice(0, 2),
        do: {:cont, true},
        else: {:halt, false}
    end)
  end

  @doc """
  Converts an integer to a binary-formatted string

  iex> UnicodeChecker.to_bin(107)
  "01101011"
  """
  def to_bin(int) do
    int |> Integer.to_string(2) |> String.pad_leading(8, "0")
  end

  @doc """
  Method 2: Returns true if the given byte sequence is valid unicode. False,
  otherwise.
  """
  @spec valid_2?(binary) :: boolean
  def valid_2?(<<_::utf8, rest::binary>>), do: valid_2?(rest)
  def valid_2?(<<_::size(8), _::binary>>), do: false
  def valid_2?(""), do: true

  @doc """
  Method 3: Returns true if the given byte sequence is valid unicode. False,
  otherwise.
  """
  @spec valid_3?(binary) :: boolean
  def valid_3?(sequence) do
    String.valid?(sequence)
  end
end
