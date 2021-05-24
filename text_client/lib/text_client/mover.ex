defmodule TextClient.Mover do

  alias TextClient.State

  def make_move(game) do
    {game_state, tally} = Hangman.make_move(game.game_service, game.guessed)
    %State{game | game_service: game_state, tally: tally}
  end
end
