defmodule Hangman.Server do

  use GenServer #identifies this module as a GenServer and predefines default callbacks

  alias Hangman.Game

  #starts the actual GenServer
  def start_link() do
    GenServer.start_link(__MODULE__, nil) #creates a new process that will call callbacks defined in this module (i.e init)
  end

  def init(_) do
    {:ok, Game.new_game() } #returns status and process state which is just the result of creating a new game
  end

  def handle_call({:make_move, guess}, _from, game) do
    {game, tally} = Game.make_move(game, guess)
    {:reply, tally, game}
  end

  def handle_call({:tally}, _from, game) do
    {:reply, Game.tally(game), game}
  end

end
