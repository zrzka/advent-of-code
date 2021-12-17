# https://adventofcode.com/2021/day/2

# Part 1

parse_command = fn s ->
  [command, n] = String.split(s)

  {
    command |> String.to_existing_atom(),
    n |> Integer.parse() |> elem(0)
  }
end

run_command_1 = fn
  {:forward, n}, {hpos, depth} ->
    {hpos + n, depth}

  {:up, n}, {hpos, depth} ->
    {hpos, depth - n}

  {:down, n}, {hpos, depth} ->
    {hpos, depth + n}
end

File.stream!("02-input.txt")
|> Stream.map(parse_command)
|> Enum.reduce({0, 0}, run_command_1)
|> Tuple.product()
|> IO.puts()

# Part 2

run_command_2 = fn
  {:down, n}, {hpos, depth, aim} ->
    {hpos, depth, aim + n}

  {:up, n}, {hpos, depth, aim} ->
    {hpos, depth, aim - n}

  {:forward, n}, {hpos, depth, aim} ->
    {hpos + n, depth + aim * n, aim}
end

File.stream!("02-input.txt")
|> Stream.map(parse_command)
|> Enum.reduce({0, 0, 0}, run_command_2)
|> Tuple.delete_at(2)
|> Tuple.product()
|> IO.puts()
