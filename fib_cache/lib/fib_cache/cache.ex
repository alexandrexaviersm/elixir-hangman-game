defmodule FibCache.Cache do
  @me __MODULE__

  def start() do
    Agent.start_link(fn -> %{0 => 0, 1 => 1} end, name: @me)
  end

  def update_cache(result, elem) do
    Agent.update(@me, fn cache -> Map.put(cache, elem, result) end)
    result
  end

  def get_cache() do
    Agent.get(@me, & &1)
  end
end
