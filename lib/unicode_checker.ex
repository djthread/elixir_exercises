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
  def valid?(<<0::size(1), _::size(7), rest::binary>>), do: valid?(rest)
  def valid?(<<6::size(3), _::size(5), 2::size(2), _::size(6), rest::binary>>), do: valid?(rest)
  def valid?(<<14::size(4), _::size(4), 2::size(2), _::size(6), 2::size(2), _::size(6), rest::binary>>), do: valid?(rest)
  def valid?(<<30::size(5), _::size(3), 2::size(2), _::size(6), 2::size(2), _::size(6), 2::size(2), _::size(6), rest::binary>>), do: valid?(rest)
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
