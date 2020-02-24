defmodule TodoGenTest do
  use ExUnit.Case
  doctest TodoGen

  test "greets the world" do
    assert TodoGen.hello() == :world
  end
end
