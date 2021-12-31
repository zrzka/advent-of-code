defmodule Aoc.Y2021.Day01Test do
  use ExUnit.Case
  doctest Aoc

  test "verify results" do
    {p1, p2} = Aoc.Y2021.Day01.results("inputs/2021/day01.txt")

    assert p1 == 1387
    assert p2 == 1362
  end
end
