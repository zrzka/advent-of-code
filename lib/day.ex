defmodule Aoc.Day do
  @callback results(String.t) :: {String.t} | {String.t, String.t}
end
