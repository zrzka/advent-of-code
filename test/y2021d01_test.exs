defmodule Aoc.Y2021D01Test do
  use ExUnit.Case
  doctest Aoc

  test "verify results" do
    {p1, p2} = Aoc.Y2021D01.results("inputs/y2021d01.txt")

    assert p1 == 1387
    assert p2 == 1362
  end
end
