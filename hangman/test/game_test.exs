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
            assert {^game, _ } = Game.make_move(game, "x")
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
        game = Game.new_game("lebron")

        {game, _tally} = Game.make_move(game, "a")

        assert game.game_state == :bad_guess
        assert game.turns_left == 6

        {game, _tally} = Game.make_move(game, "x")

        assert game.game_state == :bad_guess
        assert game.turns_left == 5

        {game, _tally} = Game.make_move(game, "c")

        assert game.game_state == :bad_guess
        assert game.turns_left == 4

        {game, _tally} = Game.make_move(game, "d")

        assert game.game_state == :bad_guess
        assert game.turns_left == 3

        {game, _tally} = Game.make_move(game, "f")

        assert game.game_state == :bad_guess
        assert game.turns_left == 2

        {game, _tally} = Game.make_move(game, "g")

        assert game.game_state == :bad_guess
        assert game.turns_left == 1

        {game, _tally} = Game.make_move(game, "k")

        assert game.game_state == :lost
        assert game.turns_left == 0


    end



end
