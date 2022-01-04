defmodule Aoc.Y2021.Day06 do
  @moduledoc """
  --- Day 6: Lanternfish ---

  https://adventofcode.com/2021/day/6
  """

  @behaviour Aoc.Day

  @impl true
  def results(path) do
    fish =
      parse(path)
      |> Enum.frequencies()

    part1 =
      Enum.reduce(1..80, fish, fn _, acc -> simulate_day(acc) end)
      |> Enum.reduce(0, fn {_, x}, acc -> x + acc end)

    part2 =
      Enum.reduce(1..256, fish, fn _, acc -> simulate_day(acc) end)
      |> Enum.reduce(0, fn {_, x}, acc -> x + acc end)

    {part1, part2}
  end

  defp simulate_day(fish) do
    shifted =
      Enum.reduce(0..8, fish, fn x, acc ->
        Map.put(acc, x - 1, Map.get(acc, x, 0))
      end)

    case Map.pop(shifted, -1) do
      {nil, acc} ->
        acc

      {x, acc} ->
        Map.update(acc, 6, 0, &(&1 + x))
        |> Map.put(8, x)
    end
  end

  defp parse(path) do
    File.stream!(path)
    |> Stream.map(&String.trim/1)
    |> Enum.take(1)
    |> hd
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end
end
