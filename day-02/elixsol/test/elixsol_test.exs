defmodule ElixsolTest do
  use ExUnit.Case
  doctest Elixsol

  test "works for example input" do
    {ok, val} = File.read("../example.txt")
    if !ok do
      raise "Could not read file"
    end
    assert Elixsol.one(val) == 8
    assert Elixsol.two(val) == 2286
  end
end
