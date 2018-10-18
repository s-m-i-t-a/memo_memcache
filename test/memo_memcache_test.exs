defmodule MemoMemcacheTest do
  use ExUnit.Case
  use PropCheck
  doctest MemoMemcache

  defmodule FakeErrorCache do
    def set(_key, _value, _opts) do
      {:error, :bad_cache}
    end
  end

  # Tests

  test "should set return error" do
    assert MemoMemcache.set({:a, :b, [1, 2]}, "test", 10, FakeErrorCache) == {:error, :bad_cache}
  end

  # Properties

  property "should store and get value from cache" do
    forall [key, val] <- [mfa(), value()] do
      Memcachir.flush()
      assert MemoMemcache.set(key, val, 10) == MemoMemcache.get(key)
    end
  end

  property "should return error if value not found" do
    forall key <- mfa() do
      Memcachir.flush()
      assert MemoMemcache.get(key) == {:error, "Key not found"}
    end
  end

  # Helpers

  # Generators

  defp mfa() do
    {atom(), atom(), list()}
  end

  defp value() do
    oneof([
      utf8(),
      atom(),
      number(),
      bool(),
      list(),
      tuple()
    ])
  end
end
