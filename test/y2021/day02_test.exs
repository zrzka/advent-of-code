defmodule Aoc.Y2021.Day02Test do
  use ExUnit.Case
  doctest Aoc

  test "verify results" do
    {p1, p2} = Aoc.Y2021.Day02.results("inputs/2021/day02.txt")

    assert p1 == 1_727_835
    assert p2 == 1_544_000_595
  end
end
