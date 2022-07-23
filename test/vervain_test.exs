defmodule VervainTest do
  use ExUnit.Case
  doctest Vervain

  test "greets the world" do
    assert Vervain.hello() == :world
  end
end
