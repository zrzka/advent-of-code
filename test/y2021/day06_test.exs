defmodule Aoc.Y2021.Day06Test do
  use ExUnit.Case
  doctest Aoc

  test "verify results" do
    {p1, p2} = Aoc.Y2021.Day06.results("inputs/2021/day06.txt")

    assert p1 == 360_761
    assert p2 == 1_632_779_838_045
  end
end
