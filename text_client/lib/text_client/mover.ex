defmodule TextClient.Mover do

  alias TextClient.State

  def make_move(game) do
    tally = Hangman.make_move(game.game_service, game.guessed)
    %State{game | tally: tally}
  end
end
