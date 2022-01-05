defmodule Aoc.Y2021.Day07Test do
  use ExUnit.Case
  doctest Aoc

  test "verify results" do
    {p1, p2} = Aoc.Y2021.Day07.results("inputs/2021/day07.txt")

    assert p1 == 336_701
    assert p2 == 95_167_302
  end
end
