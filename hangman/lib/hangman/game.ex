 defmodule Hangman.Game do

    #used at the module level to specify keys & default values
    defstruct(
        turns_left: 7,
        game_state: :initializing,
        letters: [],
        used: MapSet.new(),
    )

    #initialize game with specific word
    def new_game(word) do
        #same syntax as regular map, but uses module name to access defstruct
        %Hangman.Game{letters: word |> String.codepoints}
    end

    #initialize game with random word
    def new_game() do
        new_game(Dictionary.random_word)
    end

    #pattern matching with game state - executes if game_state is already won or lost
    def make_move(game = %{game_state: state}, _guess) when state in [:won, :lost] do
        {game, tally(game)} #return game
    end

    def make_move(game, guess) do
        game = accept_move(game, guess, MapSet.member?(game.used, guess))
        {game, tally(game)} #return game
    end

    #already guessed is true
    def accept_move(game, guess, _already_guessed = true) do
        Map.put(game, :game_state, :already_used)
    end

    #already guessed is false
    def accept_move(game, guess, _already_guessed) do
        Map.put(game, :used, MapSet.put(game.used, guess)) #add guess to used letters
        |> score_guess(Enum.member?(game.letters, guess)) #check if guess is in the word
    end

    def score_guess(game, _good_guess = true) do
        new_state = MapSet.new(game.letters)
        |> MapSet.subset?(game.used)
        |> maybe_won()

        Map.put(game, :game_state, new_state)
    end

    #lost game
    def score_guess(game = %{turns_left: 1}, _good_guess = false) do
        %{game |
        game_state: :lost,
        turns_left: 0
        }
    end

    #bad guess but still have turns remaining
    def score_guess(game = %{turns_left: turns_left}, _good_guess = false) do
        %{game |
        game_state: :bad_guess,
        turns_left: (turns_left - 1)
        }
    end

    #all letters guessed
    def maybe_won(true), do: :won
    # not all letters guessed yet
    def maybe_won(false), do: :good_guess



    def tally(game) do
        123
    end


end
