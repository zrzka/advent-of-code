# https://adventofcode.com/2021/day/3

defmodule Aoc.Y2021D03 do
  @behaviour Aoc.Day

  @impl true
  def results(path) do
    numbers = parse(path)

    one_counts =
      numbers
      |> Enum.reduce([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], &counter/2)

    {power_consumption(one_counts), life_support_rating(numbers, one_counts)}
  end

  defp parse(path) do
    File.stream!(path)
    |> Stream.map(&String.trim/1)
    |> Enum.map(&to_numbers/1)
  end

  defp to_numbers(line) do
    # TODO: This looks like super ineeficient way (UTF-8, graphemes, ...)
    #       Look at binary matching and process raw bytes
    line
    |> String.graphemes()
    |> Enum.map(fn
      "1" -> 1
      _ -> 0
    end)
  end

  defp counter(el, [lines | counts]) do
    new_counts =
      [counts, el]
      |> Enum.zip()
      |> Enum.map(&Tuple.sum/1)

    [lines + 1 | new_counts]
  end

  #
  # Part 1
  #

  defp gamma_rate_bit(one_count, half_lines_count) when half_lines_count > one_count do
    1
  end

  defp gamma_rate_bit(_, _) do
    0
  end

  defp epsilon_rate_bit(one_count, half_lines_count) when half_lines_count < one_count do
    1
  end

  defp epsilon_rate_bit(_, _) do
    0
  end

  defp power_consumption([lines_count | one_counts]) do
    half_lines_count = div(lines_count, 2)

    gamma_rate =
      one_counts
      |> Enum.map_join(&gamma_rate_bit(&1, half_lines_count))
      |> Integer.parse(2)
      |> elem(0)

    epsilon_rate =
      one_counts
      |> Enum.map_join(&epsilon_rate_bit(&1, half_lines_count))
      |> Integer.parse(2)
      |> elem(0)

    gamma_rate * epsilon_rate
  end

  #
  # Part 2
  #

  defp oxygen_bits_to_keep([lines | counts]) do
    Enum.map(counts, fn
      cnt when cnt >= lines - cnt ->
        1

      _ ->
        0
    end)
  end

  defp co_bits_to_keep([lines | counts]) do
    Enum.map(counts, fn
      cnt when cnt < lines - cnt ->
        1

      _ ->
        0
    end)
  end

  defp find_longest_matching(_bits_to_keep, _position, [last] = _numbers, [] = _matching) do
    last
  end

  defp find_longest_matching(bits_to_keep, position, [] = _numbers, matching) do
    find_longest_matching(bits_to_keep, position + 1, matching, [])
  end

  defp find_longest_matching(bits_to_keep, position, [number | rest] = _numbers, matching) do
    if Enum.at(number, position) == Enum.at(bits_to_keep, position) do
      # TODO: Check other data structures/types, `++ [number]` is slow O(N)
      find_longest_matching(bits_to_keep, position, rest, matching ++ [number])
    else
      find_longest_matching(bits_to_keep, position, rest, matching)
    end
  end

  defp life_support_rating(numbers, counts) do
    oxygen_bits = oxygen_bits_to_keep(counts)

    oxygen_rating =
      find_longest_matching(oxygen_bits, 0, numbers, [])
      |> Enum.join()
      |> Integer.parse(2)
      |> elem(0)

    co_bits = co_bits_to_keep(counts)

    co_rating =
      find_longest_matching(co_bits, 0, numbers, [])
      |> Enum.join()
      |> Integer.parse(2)
      |> elem(0)

    oxygen_rating * co_rating
  end
end
