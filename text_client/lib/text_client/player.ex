defmodule TextClient.Player do

  alias TextClient.{Prompter, State, Summary, Mover}

  # game won
  def play(game = %State{tally: %{game_state: :won}} ) do
    exit_with_message("You WON!")
  end

  #game lost
  def play(game = %State{tally: %{game_state: :lost}} ) do
    exit_with_message("You LOST!")
  end

  #good guess
  def play(game = %State{tally: %{game_state: :good_guess}} ) do
    continue_with_message(game, "Good guess!")
  end

  #bad guess
  def play(game = %State{tally: %{game_state: :bad_guess}} ) do
    continue_with_message(game, "Bad guess! That letter isn't in the word.")
  end

  #already used letter
  def play(game = %State{tally: %{game_state: :already_used}} ) do
    continue_with_message(game, "You've already used that letter!")
  end

  #initialising case
  def play(game) do
    continue(game)
  end

  defp exit_with_message(msg) do
    IO.puts(msg)
    exit(:normal)
  end

  def continue_with_message(game, msg) do
    IO.puts(msg)
    continue(game)
  end

  def make_move(game) do
    game
  end

  # game -> display -> prompt -> make_move -> play
  def continue(game) do
    game
    |> Summary.display()
    |> Prompter.accept_move()
    |> Mover.make_move()
    |> play()
  end

end
