defmodule Dictionary.Application do

  use Application #sets up default settings for Elixir app

  #callback that starts the application process
  def start(_type, _args) do
    Dictionary.WordList.start_link()
  end

end
