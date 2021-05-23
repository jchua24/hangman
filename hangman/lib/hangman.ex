defmodule Hangman do

  #redirecting API call to where it is implemented
  alias Hangman.Game
  defdelegate new_game(), to: Game

end
