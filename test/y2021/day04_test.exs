defmodule Aoc.Y2021.Day04Test do
  use ExUnit.Case
  doctest Aoc

  test "verify results" do
    {p1, p2} = Aoc.Y2021.Day04.results("inputs/2021/day04.txt")

    assert p1 == 63552
    assert p2 == 9020
  end
end
