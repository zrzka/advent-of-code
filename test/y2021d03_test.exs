defmodule Aoc.Y2021D03Test do
  use ExUnit.Case
  doctest Aoc

  test "verify results" do
    {p1, _p2} = Aoc.Y2021D03.results("inputs/y2021d03.txt")

    assert p1 == 4_006_064
  end
end
