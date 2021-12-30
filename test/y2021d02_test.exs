defmodule Aoc.Y2021D02Test do
  use ExUnit.Case
  doctest Aoc

  test "verify results" do
    {p1, p2} = Aoc.Y2021D02.results("inputs/y2021d02.txt")

    assert p1 == 1_727_835
    assert p2 == 1_544_000_595
  end
end
