defmodule FibCache.Application do
  use Application

  def start(_, _) do
    FibCache.Cache.start()
  end
end
