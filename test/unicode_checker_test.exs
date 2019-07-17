defmodule UnicodeCheckerTest do
  use ExUnit.Case
  doctest UnicodeChecker

  @cases [
    {true, <<197, 130, 1>>},
    {false, <<235, 140, 4>>}
  ]

  test "method 2" do
    Enum.each(@cases, fn {valid?, binary} ->
      assert valid? == UnicodeChecker.valid_2?(binary)
    end)
  end

  test "method 3, pointless (tests elixir)" do
    Enum.each(@cases, fn {valid?, binary} ->
      assert valid? == UnicodeChecker.valid_3?(binary)
    end)
  end
end
