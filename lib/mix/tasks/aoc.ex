defmodule Mix.Tasks.Aoc do
  @moduledoc """
  Prints AoC day results. It expects a day number.

      mix aoc --day N

  ## Examples

      mix aoc --day 1
  """

  @shortdoc "Prints AoC day results"

  use Mix.Task

  @impl Mix.Task
  def run(args) do
    {opts, _} = OptionParser.parse!(args, strict: [day: :integer])

    year = 2021

    days =
      case Keyword.fetch(opts, :day) do
        {:ok, day} -> day..day
        :error -> 1..25
      end

    days
    |> Enum.each(&run(year, &1))
  end

  defp run(year, day) do
    fmt_day =
      day
      |> Integer.to_string()
      |> String.pad_leading(2, "0")

    try do
      String.to_existing_atom("Elixir.Aoc.Y#{year}.Day#{fmt_day}")
    rescue
      ArgumentError ->
        Mix.shell().info("#{year}-12-#{fmt_day}, part 1: N/A")
        Mix.shell().info("#{year}-12-#{fmt_day}, part 2: N/A")
    else
      func ->
        case apply(func, :results, ["inputs/#{year}/day#{fmt_day}.txt"]) do
          {part1} ->
            Mix.shell().info("#{year}-12-#{fmt_day}, part 1: #{part1}")
            Mix.shell().info("#{year}-12-#{fmt_day}, part 2: N/A")

          {part1, part2} ->
            Mix.shell().info("#{year}-12-#{fmt_day}, part 1: #{part1}")
            Mix.shell().info("#{year}-12-#{fmt_day}, part 2: #{part2}")
        end
    end
  end
end
