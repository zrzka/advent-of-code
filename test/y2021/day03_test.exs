defmodule Aoc.Y2021.Day03Test do
  use ExUnit.Case
  doctest Aoc

  test "verify results" do
    {p1, p2} = Aoc.Y2021.Day03.results("inputs/2021/day03.txt")

    assert p1 == 4_006_064
    assert p2 == 5_941_884
  end
end
