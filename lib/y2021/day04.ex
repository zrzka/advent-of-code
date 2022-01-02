defmodule Aoc.Y2021.Day04 do
  @moduledoc """
  --- Day 4: Giant Squid ---

  https://adventofcode.com/2021/day/4
  """

  import Aoc.Helpers.Matrix

  @behaviour Aoc.Day

  @impl true
  def results(path) do
    {numbers_to_draw, boards} = parse(path)

    {winning_board_score(boards, numbers_to_draw),
     last_winning_board_score(boards, numbers_to_draw)}
  end

  defp last_winning_board_score(boards, numbers_to_draw, drawn \\ [], last_score \\ nil) do
    cond do
      drawn == [] ->
        [called | rest] = numbers_to_draw
        last_winning_board_score(boards, rest, [called], last_score)

      boards == [] ->
        last_score

      numbers_to_draw == [] ->
        last_score

      true ->
        case Enum.filter(boards, &is_winning?(&1, drawn)) do
          [] ->
            [called | rest] = numbers_to_draw
            last_winning_board_score(boards, rest, [called | drawn], last_score)

          winning ->
            boards = Enum.reject(boards, &is_winning?(&1, drawn))
            last_score = board_score(Enum.at(winning, -1), drawn)
            [called | rest] = numbers_to_draw
            last_winning_board_score(boards, rest, [called | drawn], last_score)
        end
    end
  end

  defp winning_board_score(boards, numbers_to_draw) do
    [called | rest] = numbers_to_draw
    winning_board_score(boards, rest, [called])
  end

  defp winning_board_score(boards, numbers_to_draw, drawn) do
    case Enum.find(boards, &is_winning?(&1, drawn)) do
      nil ->
        [called | rest] = numbers_to_draw
        winning_board_score(boards, rest, [called | drawn])

      board ->
        board_score(board, drawn)
    end
  end

  defp is_winning?(board, drawn) do
    winning = &(&1 -- drawn == [])

    case Enum.find(board, winning) do
      nil ->
        board
        |> transpose()
        |> Enum.find(winning)

      board ->
        board
    end
  end

  defp board_score(board, [called | rest]) do
    unmarked = List.flatten(board) -- [called | rest]
    Enum.sum(unmarked) * called
  end

  defp parse(path) do
    stream =
      File.stream!(path)
      |> Stream.map(&String.trim/1)

    numbers =
      stream
      |> Stream.take(1)
      |> Enum.at(0)
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    boards =
      stream
      |> Stream.drop(2)
      |> Stream.chunk_every(5, 6, :discard)
      |> Stream.map(fn rows ->
        Enum.map(rows, &parse_board_row/1)
      end)

    {numbers, boards}
  end

  defp parse_board_row(row) do
    row
    |> String.split(~r{\s+})
    |> Enum.map(&String.to_integer/1)
  end
end
