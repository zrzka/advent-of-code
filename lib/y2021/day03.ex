defmodule Aoc.Y2021.Day03 do
  @moduledoc """
  --- Day 3: Binary Diagnostic ---

  https://adventofcode.com/2021/day/3
  """

  import Aoc.Helpers.Matrix

  @behaviour Aoc.Day

  @impl true
  def results(path) do
    bits_lines = parse(path)
    {power_consumption(bits_lines), life_support_rating(bits_lines)}
  end

  defp parse(path) do
    File.stream!(path)
    |> Stream.map(&String.trim/1)
    |> Enum.map(&String.graphemes/1)
  end

  #
  # Part 1
  #

  defp gamma_rate_bit(freqs) do
    if Map.get(freqs, "1", 0) > Map.get(freqs, "0", 0), do: "1", else: "0"
  end

  defp epsilon_rate_bit(freqs) do
    if Map.get(freqs, "1", 0) < Map.get(freqs, "0", 0), do: "1", else: "0"
  end

  defp power_consumption(bits_lines) do
    freqs =
      bits_lines
      |> transpose()
      |> Enum.map(&Enum.frequencies/1)

    gamma_rate =
      freqs
      |> Enum.map_join(&gamma_rate_bit/1)
      |> Integer.parse(2)
      |> elem(0)

    epsilon_rate =
      freqs
      |> Enum.map_join(&epsilon_rate_bit/1)
      |> Integer.parse(2)
      |> elem(0)

    gamma_rate * epsilon_rate
  end

  #
  # Part 2
  #

  defp oxygen_bit(freqs) do
    if Map.get(freqs, "1", 0) >= Map.get(freqs, "0", 0), do: "1", else: "0"
  end

  def co_bit(freqs) do
    if Map.get(freqs, "0", 0) <= Map.get(freqs, "1", 0), do: "0", else: "1"
  end

  defp find_longest_matching(bit_fn, position, bits_lines) do
    bit_to_keep =
      bits_lines
      |> transpose()
      |> Enum.map(&Enum.frequencies/1)
      |> Enum.at(position)
      |> bit_fn.()

    matching =
      bits_lines
      |> Enum.filter(fn x -> Enum.at(x, position) == bit_to_keep end)

    case matching do
      [last] -> last
      rest -> find_longest_matching(bit_fn, position + 1, rest)
    end
  end

  defp life_support_rating(bits_lines) do
    oxygen_rating =
      find_longest_matching(&oxygen_bit/1, 0, bits_lines)
      |> Enum.join()
      |> Integer.parse(2)
      |> elem(0)

    co_rating =
      find_longest_matching(&co_bit/1, 0, bits_lines)
      |> Enum.join()
      |> Integer.parse(2)
      |> elem(0)

    oxygen_rating * co_rating
  end
end
