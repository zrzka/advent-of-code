defmodule Aoc.Helpers.Matrix do
  @moduledoc """
  Matrix related helper functions.
  """

  def transpose(m) do
    m
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end
end
