defmodule HangmanBootTest do
  use ExUnit.Case
  doctest HangmanBoot

  test "greets the world" do
    assert HangmanBoot.hello() == :world
  end
end
