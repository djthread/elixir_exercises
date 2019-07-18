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

    iex> <<248, 1, 1, 1, 1, 1>> |> UnicodeChecker.valid?()
    false

  """
  @spec valid?(binary) :: boolean
  def valid?(<<0::1, _::7, rest::binary>>), do: valid?(rest)
  def valid?(<<6::3, _::5, 2::2, _::6, rest::binary>>), do: valid?(rest)
  def valid?(<<14::4, _::4, 2::2, _::6, 2::2, _::6, rest::binary>>), do: valid?(rest)
  def valid?(<<30::5, _::3, 2::2, _::6, 2::2, _::6, 2::2, _::6, rest::binary>>), do: valid?(rest)
  def valid?(<<>>), do: true
  def valid?(_), do: false

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
