# MemoMemcache

`MemoMemcache` is the adapter between the [Memo library](https://github.com/s-m-i-t-a/memo)
and memcached (specifically [Memcachir](https://github.com/peillis/memcachir)).


## Installation

```elixir
def deps do
  [
    {:memo_memcache, "~> 0.1.0"}
  ]
end
```

## Use

For the correct use `Memcachier` must be configured (`config/config.exs` content):

```elixir
config :memcachir,
  hosts: System.get_env("MEMCACHE_SERVERS") || "localhost:11211",
  ttl: System.get_env("MEMCACHE_DEFAULT_TTL") || 172_800,
  coder: Memcache.Coder.Erlang,
  auth: {
    :plain,
    System.get_env("MEMCACHE_USERNAME"),
    System.get_env("MEMCACHE_PASSWORD")
  }
```

then you can use `MemoMemcache` as a cache in the `Memo.memoize`:

```elixir
Memo.memoize(Kernel, :div, [5, 2], cache: MemoMemcache)
```


## License

[BSD3](https://github.com/s-m-i-t-a/memo_memcache/blob/master/LICENSE)

----
Created:  2018-10-17Z
