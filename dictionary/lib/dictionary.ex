defmodule Dictionary do
  def random_word do
    word_list()
    |> Enum.random()
  end

  def word_list do
    "../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split("\n")
  end
end

defmodule Testing do
  def trade_parameters({a, b}), do: {b, a}

  def equal_parameters(a, a), do: true

  def equal_parameters(_, _), do: false
end

defmodule Lists do
  def len([]), do: 0
  def len([_h | t]), do: 1 + len(t)

  def sum([]), do: 0
  def sum([h | t]), do: h + sum(t)

  def double([]), do: []
  def double([h | t]), do: [h * 2 | double(t)]

  def square([]), do: []
  def square([h | t]), do: [h * h | square(t)]

  def sum_pairs([]), do: []
  def sum_pairs([h1, h2 | t]), do: [h1 + h2 | sum_pairs(t)]
  def sum_pairs([h | t]), do: [h | sum_pairs(t)]

  def even_length?([]), do: true
  def even_length?([_h1, _h2 | t]), do: even_length?(t)
  def even_length?([_h | _t]), do: false
end
