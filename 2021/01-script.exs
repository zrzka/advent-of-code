# https://adventofcode.com/2021/day/1

# Part 1
#
# Count increases
#
# increases += 1 if x[i + 1] > x[i]

counter = fn
  x, {:increases, inc, :previous, prev} when x > prev ->
    {:increases, inc + 1, :previous, x}

  x, {:increases, inc, :previous, _prev} ->
    {:increases, inc, :previous, x}

  x, {:increases, inc} ->
    {:increases, inc, :previous, x}
end

File.stream!("01-input.txt")
|> Stream.map(&Integer.parse/1)
|> Stream.map(&elem(&1, 0))
|> Enum.reduce({:increases, 0}, counter)
|> elem(1)
|> IO.puts()

# Part 2
#
# Count increases of sums (sliding window of three elements)
#
# increases += 1 if x[i + 1] + x[i + 2] + x[i + 3] > x[i] + x[i + 1] + x[i + 2]

File.stream!("01-input.txt")
|> Stream.map(&Integer.parse/1)
|> Stream.map(&elem(&1, 0))
|> Stream.chunk_every(3, 1, :discard)
|> Stream.map(&Enum.sum(&1))
|> Enum.reduce({:increases, 0}, counter)
|> elem(1)
|> IO.puts()
