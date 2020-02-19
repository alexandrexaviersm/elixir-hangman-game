defmodule FibCache do
  alias FibCache.Fibonacci

  defdelegate fib(elem), to: Fibonacci
end
