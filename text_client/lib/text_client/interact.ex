defmodule TextClient.Interact do

  @hangman_server :"hangman@jgodwinchua-C02TJ0L3HF1T"
  alias TextClient.{State, Player}

  def start() do
    new_game()
    |> setup_state()
    |> Player.play()
  end

  defp setup_state(game) do
    %State{
      game_service: game,
      tally: Hangman.tally(game)
    }
  end

  defp new_game() do
    #make a call to start a Hangman server
    Node.connect(@hangman_server)
    :rpc.call(@hangman_server, Hangman, :new_game, []) #call hangman server and start new game
  end
end
