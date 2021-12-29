# https://adventofcode.com/2021/day/2

defmodule Aoc.Y2021D02 do
  @behaviour Aoc.Day

  @impl true
  def results(path) do
    commands =
      File.stream!(path)
      |> Enum.map(&parse_command/1)

    part1 =
      commands
      |> Enum.reduce({0, 0}, &run/2)
      |> Tuple.product()

    part2 =
      commands
      |> Enum.reduce({0, 0, 0}, &run/2)
      |> Tuple.delete_at(2)
      |> Tuple.product()

    {part1, part2}
  end

  defp parse_command(s) do
    [command, n] = String.split(s)

    {
      command |> String.to_existing_atom(),
      n |> Integer.parse() |> elem(0)
    }
  end

  #
  # Part 1
  #

  defp run({:forward, n}, {hpos, depth}) do
    {hpos + n, depth}
  end

  defp run({:up, n}, {hpos, depth}) do
    {hpos, depth - n}
  end

  defp run({:down, n}, {hpos, depth}) do
    {hpos, depth + n}
  end

  #
  # Part 2
  #

  defp run({:down, n}, {hpos, depth, aim}) do
    {hpos, depth, aim + n}
  end

  defp run({:up, n}, {hpos, depth, aim}) do
    {hpos, depth, aim - n}
  end

  defp run({:forward, n}, {hpos, depth, aim}) do
    {hpos + n, depth + aim * n, aim}
  end
end
