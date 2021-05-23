defmodule GameTest do 

    use ExUnit.Case
    alias Hangman.Game
    
    test "new_game returns structure" do 
        game = Game.new_game() 

        assert game.turns_left == 7
        assert game.game_state == :initializing
        assert length(game.letters) > 0 

        lstring = List.to_string(game.letters)

        assert lstring == String.downcase(lstring)
    end 

    test "state isn't changed for :won game" do 
        game = Game.new_game() |> Map.put(:game_state, :won)

        #tests that game is unchanged after being returned 
        assert {^game, _ } = Game.make_move(game, "x")
    end 

end 