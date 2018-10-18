use Mix.Config

#     config(:memo_memcache, key: :value)
#
# And access this configuration in your application as:
#
#     Application.get_env(:memo_memcache, :key)
#
# Or configure a 3rd-party app:
#
#     config(:logger, level: :info)
#

# Memcache
config :memcachir,
  hosts: System.get_env("MEMCACHE_SERVERS"),
  ttl: System.get_env("MEMCACHE_DEFAULT_TTL") || 172_800,
  coder: Memcache.Coder.Erlang,
  auth: {
    :plain,
    System.get_env("MEMCACHE_USERNAME"),
    System.get_env("MEMCACHE_PASSWORD")
  }

# Example per-environment config:
#
#     import_config("#{Mix.env}.exs")
