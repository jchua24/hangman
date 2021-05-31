defmodule GameTest do

    use ExUnit.Case
    alias Hangman.Game

    #testing contents of game struct
    test "new_game returns structure" do
        game = Game.new_game()

        assert game.turns_left == 7
        assert game.game_state == :initializing
        assert length(game.letters) > 0

        lstring = List.to_string(game.letters)

        assert lstring == String.downcase(lstring)
    end

    test "state isn't changed for :won or :lost game" do
        for state <- [:won, :lost] do
            game = Game.new_game() |> Map.put(:game_state, state)

            #tests that game is unchanged after being returned
            assert {^game, _tally} = Game.make_move(game, "x")
        end
    end

    test "first occurence of letter is not already used" do
        game = Game.new_game()
        {game, _tally} = Game.make_move(game, "x")
        assert game.game_state != :already_used
    end

    test "second occurence of letter is already used" do
        game = Game.new_game()
        {game, _tally} = Game.make_move(game, "x")
        assert game.game_state != :already_used

        {game, _tally} = Game.make_move(game, "x")
        assert game.game_state == :already_used
    end

    test "a good guess is recognized " do
        game = Game.new_game("lebron")
        {game, _tally} = Game.make_move(game, "l")

        #correct state, and a turn isn't used
        assert game.game_state == :good_guess
        assert game.turns_left == 7
    end


    test "a guessed word is a won game" do
        game = Game.new_game("lebron")

        {game, _tally} = Game.make_move(game, "l")
        {game, _tally} = Game.make_move(game, "e")
        {game, _tally} = Game.make_move(game, "b")
        {game, _tally} = Game.make_move(game, "r")
        {game, _tally} = Game.make_move(game, "o")
        {game, _tally} = Game.make_move(game, "n")

        assert game.game_state == :won
        assert game.turns_left == 7
    end

    test "bad guess is recognized" do
        game = Game.new_game("lebron")
        {game, _tally} = Game.make_move(game, "a")

        assert game.game_state == :bad_guess
        assert game.turns_left == 6
    end

    test "losing game is recognized" do

        moves = [
            {"a", :bad_guess, 6},
            {"x", :bad_guess, 5 },
            {"c", :bad_guess, 4},
            {"d", :bad_guess, 3},
            {"f", :bad_guess, 2},
            {"g", :bad_guess, 1},
            {"k", :lost, 0}
          ]

        game = Game.new_game("lebron")

        Enum.reduce(moves, game, fn({guess, state, remaining}, new_game) ->
            {new_game, _tally} = Game.make_move(new_game, guess)
            assert new_game.game_state == state
            assert new_game.turns_left == remaining
            new_game
            end
        )
    end

    test "using list comprehension" do
        moves = [
            {"w", :good_guess},
            {"i", :good_guess},
            {"b", :good_guess},
            {"l", :good_guess},
            {"e", :won}
          ]

          game = Game.new_game("wibble")

          Enum.reduce(moves, game, fn({guess, state}, new_game) ->
                {new_game, _tally} = Game.make_move(new_game, guess)
                assert new_game.game_state == state
                new_game
                end
            )
    end
end
