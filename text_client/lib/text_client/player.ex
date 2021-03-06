defmodule TextClient.Player do
  alias TextClient.{Prompter, Summary, State, Mover}

  def play(%State{game_service: %{letters: letters}, tally: %{game_state: :won}}) do
    end_with_message("You WON!", letters)
  end

  def play(%State{game_service: %{letters: letters}, tally: %{game_state: :lost}}) do
    end_with_message("Sorry, you lost...", letters)
  end

  def play(game = %State{tally: %{game_state: :good_guess}}) do
    continue_with_message(game, "Good Guess!")
  end

  def play(game = %State{tally: %{game_state: :bad_guess}}) do
    continue_with_message(game, "Sorry, that isn't in the word")
  end

  def play(game = %State{tally: %{game_state: :already_used}}) do
    continue_with_message(game, "You've already used that letter")
  end

  def play(game) do
    continue(game)
  end

  def continue(game) do
    game
    |> Summary.display()
    |> Prompter.accept_move()
    |> Mover.make_move()
    |> play()
  end

  def display(game) do
    game
  end

  def prompt(game) do
    game
  end

  def make_move(game) do
    game
  end

  defp continue_with_message(game, msg) do
    IO.puts(msg)
    continue(game)
  end

  defp end_with_message(msg, letters) do
    IO.puts(["\n", msg, "The word was #{Enum.join(letters)}"])
  end
end
