defmodule MemoMemcache do
  @moduledoc """
  Memcache based memoize.
  """
  require Logger

  @behaviour Memo.Behaviour

  @impl true
  def get({module, func, args} = key, cache \\ Memcachir)
      when is_atom(module) and is_atom(func) and is_list(args) do
    key
    |> to_key()
    |> cache.get()
  end

  @impl true
  def set({module, func, args} = key, value, ttl, cache \\ Memcachir)
      when is_atom(module) and is_atom(func) and is_list(args) do
    key
    |> to_key()
    |> cache.set(value, ttl: ttl)
    |> to_result(value)
  end

  defp to_key(value) do
    :crypto.hash(:sha, :erlang.term_to_binary(value))
  end

  defp to_result({:ok}, value) do
    {:ok, value}
  end

  defp to_result({:error, msg} = err, _) do
    Logger.error(fn -> msg end)
    err
  end
end
