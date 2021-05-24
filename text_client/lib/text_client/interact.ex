defmodule TextClient.Interact do

  alias TextClient.{State, Player}

  def start() do

    #|> IO.inspect() #used to show current state of pipeline, returns whatever is passed to it

    Hangman.new_game()
    |> setup_state()
    |> Player.play()
  end

  defp setup_state(game) do
    %State{
      game_service: game,
      tally: Hangman.tally(game)
    }
  end

  def play(state) do
    #handle interactions with human player
  end
end
