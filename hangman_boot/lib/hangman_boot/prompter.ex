defmodule TextClient.Prompter do
  alias TextClient.State

  # TODO
  # (Difficult) If you’d like an interesting challenge, write another application where the computer plays the hangman game.
  # For a simple implementation you could just blindly guess letters, starting at the most frequent.

  # You could then optimize it by looking at the possible words.
  # You’ll need to add a new API function to the dictionary to return all the words of a given length.
  # You can then use that list to decide which letter will give you the most information based on the current game state.

  def accept_move(game = %State{}) do
    letter = random_letter()
    IO.puts("Computer guess: #{letter}")
    :timer.sleep(1000)
    input_letter(letter, game)
  end

  defp random_letter() do
    "abcdefghijklmnopqrstuvwxyz"
    |> String.split("", trim: true)
    |> Enum.random()
  end

  defp input_letter(letter, game = %State{}) do
    Map.put(game, :guess, letter)
  end
end
