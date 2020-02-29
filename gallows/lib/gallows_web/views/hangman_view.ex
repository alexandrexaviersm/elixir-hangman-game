defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view
  import GallowsWeb.Views.Helpers.GameStateHelper

  def turn(left, target) when target >= left do
    "dim"
  end

  def turn(left, target) do
    "faint"
  end

  def new_game_button(conn) do
    button("New Game", to: GallowsWeb.Router.Helpers.hangman_path(conn, :create_game))
  end

  def game_over?(%{game_state: game_state}) do
    game_state in [:won, :lost]
  end

  def word_so_far(tally) do
    tally.letters |> Enum.join(" ")
  end
end
