# https://adventofcode.com/2021/day/1

defmodule Aoc.Y2021D01 do
  @behaviour Aoc.Day

  @impl true
  def results(path) do
    part1 =
      File.stream!(path)
      |> Stream.map(&Integer.parse/1)
      |> Stream.map(&elem(&1, 0))
      |> Enum.reduce({:increases, 0}, &counter/2)
      |> elem(1)

    part2 =
      File.stream!(path)
      |> Stream.map(&Integer.parse/1)
      |> Stream.map(&elem(&1, 0))
      |> Stream.chunk_every(3, 1, :discard)
      |> Stream.map(&Enum.sum(&1))
      |> Enum.reduce({:increases, 0}, &counter/2)
      |> elem(1)

    {part1, part2}
  end

  defp counter(x, {:increases, inc, :previous, prev}) when x > prev do
    {:increases, inc + 1, :previous, x}
  end

  defp counter(x, {:increases, inc, :previous, _prev}) do
    {:increases, inc, :previous, x}
  end

  defp counter(x, {:increases, inc}) do
    {:increases, inc, :previous, x}
  end
end
