defmodule Aoc.Day do
  @moduledoc """
  Behaviour every AoC day must implement.
  """

  @callback results(String.t()) :: {String.t()} | {String.t(), String.t()}
end
