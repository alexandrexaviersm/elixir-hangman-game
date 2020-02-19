defmodule FibCache.Fibonacci do
  alias FibCache.Cache

  def fib(elem) do
    cond do
      result = Cache.get_cache() |> Map.get(elem) ->
        result

      true ->
        (fib(elem - 1) + fib(elem - 2))
        |> Cache.update_cache(elem)
    end
  end
end
