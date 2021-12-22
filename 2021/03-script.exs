# https://adventofcode.com/2021/day/3

defmodule Parser do
  def parse(path) do
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
end

defmodule Counter do
  def reducer(el, [lines | counts]) do
    new_counts =
      [counts, el]
      |> Enum.zip()
      |> Enum.map(&Tuple.sum/1)

    [lines + 1 | new_counts]
  end
end

defmodule PartOne do
  def gamma_rate_mapper(count, half) when count > half do
    1
  end

  def gamma_rate_mapper(_count, _half) do
    0
  end

  def epsilon_rate_mapper(count, half) when count < half do
    1
  end

  def epsilon_rate_mapper(_count, _half) do
    0
  end

  def rates([line_count | one_counts]) do
    half_line_count = div(line_count, 2)

    gamma_rate =
      one_counts
      |> Enum.map_join(&gamma_rate_mapper(&1, half_line_count))
      |> Integer.parse(2)
      |> elem(0)

    epsilon_rate =
      one_counts
      |> Enum.map_join(&epsilon_rate_mapper(&1, half_line_count))
      |> Integer.parse(2)
      |> elem(0)

    {gamma_rate, epsilon_rate}
  end
end

numbers = Parser.parse("03-input.txt")

counts = numbers |> Enum.reduce([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], &Counter.reducer/2)

counts
|> PartOne.rates()
|> Tuple.product()
# 4006064
|> IO.puts()

defmodule PartTwo do
  def oxygen_bits_to_keep([lines | counts]) do
    Enum.map(counts, fn
      cnt when cnt >= lines - cnt ->
        1

      _ ->
        0
    end)
  end

  def co_bits_to_keep([lines | counts]) do
    Enum.map(counts, fn
      cnt when cnt < lines - cnt ->
        1

      _ ->
        0
    end)
  end

  def find_longest_matching(_bits_to_keep, _position, [last] = _numbers, [] = _matching) do
    last
  end

  def find_longest_matching(bits_to_keep, position, [] = _numbers, matching) do
    find_longest_matching(bits_to_keep, position + 1, matching, [])
  end

  def find_longest_matching(bits_to_keep, position, [number | rest] = _numbers, matching) do
    if Enum.at(number, position) == Enum.at(bits_to_keep, position) do
      # TODO: Check other data structures/types, `++ [number]` is slow O(N)
      find_longest_matching(bits_to_keep, position, rest, matching ++ [number])
    else
      find_longest_matching(bits_to_keep, position, rest, matching)
    end
  end

  def rating(numbers, counts) do
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

PartTwo.rating(numbers, counts)
# FIXME: 4017694 is wrong, re-read assignment
|> IO.puts()
