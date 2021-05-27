defmodule Dictionary.WordList do

  @me __MODULE__

  #initializes the internal state - with name word_list
  def start_link() do
    Agent.start_link(&word_list/0, name: @me)
  end


  def random_word() do
    Agent.get(@me, &Enum.random/1) #calls Enum.random on state
  end

  def word_list do
    "../../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split(~r/\n/)
  end

end
