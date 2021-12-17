# https://adventofcode.com/2021/day/3

to_numbers = fn s ->
  s
  |> String.graphemes()
  |> Enum.map(fn
    "1" -> 1
    _ -> 0
  end)
end

reducer = fn
  el, [lines | counts] ->
    new_counts =
      [counts, el]
      |> Enum.zip()
      |> Enum.map(&Tuple.sum/1)

    [lines + 1 | new_counts]
end

gamma_rate_mapper = fn
  count, half when count > half ->
    "1"

  _, _ ->
    "0"
end

epsilon_rate_mapper = fn
  count, half when count < half ->
    "1"

  _, _ ->
    "0"
end

to_rates = fn
  [line_count | one_counts] ->
    half_line_count = div(line_count, 2)

    gamma_rate =
      one_counts
      |> Enum.map_join(&gamma_rate_mapper.(&1, half_line_count))
      |> Integer.parse(2)
      |> elem(0)

    epsilon_rate =
      one_counts
      |> Enum.map_join(&epsilon_rate_mapper.(&1, half_line_count))
      |> Integer.parse(2)
      |> elem(0)

    {gamma_rate, epsilon_rate}
end

rates =
  File.stream!("03-input.txt")
  |> Stream.map(&String.trim/1)
  |> Stream.map(to_numbers)
  |> Enum.reduce([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], reducer)
  |> to_rates.()

# Part 1 - 4006064
Tuple.product(rates)

# TODO: Part 2
