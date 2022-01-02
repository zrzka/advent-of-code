defmodule Aoc.Y2021.Day05Test do
  use ExUnit.Case
  doctest Aoc

  test "verify results" do
    {p1, p2} = Aoc.Y2021.Day05.results("inputs/2021/day05.txt")

    assert p1 == 0
    assert p2 == 0
  end
end
