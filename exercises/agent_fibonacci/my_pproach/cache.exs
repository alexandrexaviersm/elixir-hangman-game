defmodule Cache do
  def start() do
    Agent.start_link(fn -> %{0 => 0, 1 => 1} end)
  end

  def update_cache(result, agent, elem) do
    Agent.update(agent, fn cache -> Map.put(cache, elem, result) end)
    result
  end

  def get_cache(agent) do
    Agent.get(agent, & &1)
  end
end
