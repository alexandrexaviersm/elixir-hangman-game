defmodule Hangman.Game do
  use GenServer
  defstruct(turns_left: 7, game_state: :initializing, letters: [], used: MapSet.new())

  ### API
  def new_game do
    {:ok, pid} = Supervisor.start_child(Hangman.Supervisor, [])
    pid
  end

  def tally(game_pid) do
    GenServer.call(game_pid, {:tally})
  end

  def make_move(game_pid, guess) do
    GenServer.call(game_pid, {:make_move, guess})
  end

  ### GenServer Initialization

  def start_link() do
    GenServer.start_link(__MODULE__, Dictionary.random_word())
  end

  def start_link(word) do
    GenServer.start_link(__MODULE__, word)
  end

  ### GenServer Callbacks

  def init(word) do
    {:ok, create_state(word)}
  end

  def handle_call({:make_move, guess}, _from, game) do
    {game, tally} = do_make_move(game, guess)
    {:reply, tally, game}
  end

  def handle_call({:tally}, _from, game) do
    {:reply, do_tally(game), game}
  end

  ### GAME

  defp create_state(word) do
    %Hangman.Game{
      letters: word |> String.codepoints()
    }
  end

  defp do_make_move(game = %{game_state: state}, _guess) when state in [:won, :lost] do
    game
    |> return_with_tally()
  end

  defp do_make_move(game, guess) do
    accept_move(game, guess, MapSet.member?(game.used, guess))
    |> return_with_tally
  end

  defp do_tally(game) do
    %{
      game_state: game.game_state,
      turns_left: game.turns_left,
      letters: game.letters |> reveal_guessed(game.used),
      used_letters: game.used
    }
  end

  ##################################################################

  defp accept_move(game, _guess, _already_guessed = true) do
    Map.put(game, :game_state, :already_used)
  end

  defp accept_move(game, guess, _already_guessed) do
    Map.put(game, :used, MapSet.put(game.used, guess))
    |> score_guess(Enum.member?(game.letters, guess))
  end

  defp return_with_tally(game), do: {game, tally(game)}

  defp score_guess(game, _good_guess = true) do
    new_state =
      MapSet.new(game.letters)
      |> MapSet.subset?(game.used)
      |> maybe_won

    Map.put(game, :game_state, new_state)
  end

  defp score_guess(game = %{turns_left: 1}, _not_good_guess) do
    Map.put(game, :game_state, :lost)
  end

  defp score_guess(game = %{turns_left: turns_left}, _not_good_guess) do
    %{game | game_state: :bad_guess, turns_left: turns_left - 1}
  end

  defp reveal_guessed(letters, used) do
    letters
    |> Enum.map(fn letter -> reveal_letter(letter, MapSet.member?(used, letter)) end)
  end

  defp reveal_letter(letter, _in_word = true), do: letter
  defp reveal_letter(_letter, _not_in_word = false), do: "_"

  defp maybe_won(true), do: :won
  defp maybe_won(_), do: :good_guess
end
