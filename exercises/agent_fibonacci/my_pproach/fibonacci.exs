defmodule Fibonacci do
  def fib(elem) do
    {:ok, agent} = Cache.start()

    cond do
      result = Cache.get_cache(agent) |> Map.get(elem) ->
        result

      true ->
        (fib(agent, elem - 1) + fib(agent, elem - 2))
        |> Cache.update_cache(agent, elem)
    end
  end

  def fib(agent, elem) do
    cond do
      result = Cache.get_cache(agent) |> Map.get(elem) ->
        result

      true ->
        (fib(agent, elem - 1) + fib(agent, elem - 2))
        |> Cache.update_cache(agent, elem)
    end
  end
end
