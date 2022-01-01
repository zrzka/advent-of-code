defmodule Aoc.Helpers.Matrix do
  def transpose(m) do
    m
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end
end
