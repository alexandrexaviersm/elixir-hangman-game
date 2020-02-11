defmodule TextClient.Summary do
  def display(game = %{tally: tally}) do
    IO.puts([
      "\n",
      "Word so far: #{Enum.join(tally.letters, " ")}\n",
      "Guess left: #{tally.turns_left}\n",
      "Letters already used: #{Enum.join(MapSet.to_list(tally.used_letters), ", ")}\n"
    ])

    game
  end
end
