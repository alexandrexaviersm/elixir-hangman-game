defmodule Testing do
  def trade_parameters({a, b}), do: {b, a}

  def equal_parameters(a, a), do: true

  def equal_parameters(_, _), do: false
end
