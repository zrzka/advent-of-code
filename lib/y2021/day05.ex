defmodule Aoc.Y2021.Day05 do
  @moduledoc """
  --- Day 5: Hydrothermal Venture ---

  https://adventofcode.com/2021/day/5
  """

  @behaviour Aoc.Day

  @impl true
  def results(path) do
    lines = parse(path)

    part1 =
      lines
      |> Enum.reduce(%{}, fn {p1, p2}, acc ->
        line_points(p1, p2)
        |> Enum.reduce(acc, fn p, acc ->
          Map.update(acc, p, 1, &(&1 + 1))
        end)
      end)
      |> Enum.count(fn {_, value} -> value > 1 end)

    {part1, 0}
  end

  defp line_points({x, y1}, {x, y2}) do
    Enum.map(y1..y2, &{x, &1})
  end

  defp line_points({x1, y}, {x2, y}) do
    Enum.map(x1..x2, &{&1, y})
  end

  defp line_points(_, _) do
    []
  end

  defp parse(path) do
    File.stream!(path)
    |> Stream.map(&String.trim/1)
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(line) do
    [x1, y1, x2, y2] =
      Regex.run(~r/(\d+),(\d+) -> (\d+),(\d+)/, line, capture: :all_but_first)
      |> Enum.map(&String.to_integer/1)

    {{x1, y1}, {x2, y2}}
  end
end
