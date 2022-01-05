defmodule Aoc.Y2021.Day07 do
  @moduledoc """
  --- Day 7: The Treachery of Whales ---

  https://adventofcode.com/2021/day/7
  """

  @behaviour Aoc.Day

  @impl true
  def results(path) do
    crabs =
      parse(path)
      |> Enum.frequencies()

    {min, max} =
      crabs
      |> Map.keys()
      |> Enum.min_max()

    part1 =
      Enum.map(min..max, fn target ->
        Enum.map(crabs, fn {pos, count} -> abs(pos - target) * count end)
        |> Enum.sum()
      end)
      |> Enum.min()

    part2 =
      Enum.map(min..max, fn target ->
        Enum.map(crabs, fn {pos, count} -> Enum.sum(0..abs(pos - target)) * count end)
        |> Enum.sum()
      end)
      |> Enum.min()

    {part1, part2}
  end

  defp parse(path) do
    File.read!(path)
    |> String.trim()
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end
end
