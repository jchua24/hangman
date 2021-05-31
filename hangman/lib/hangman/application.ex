defmodule Hangman.Application do

  use Application #sets up default settings for Elixir app

  #callback that starts the application process
  def start(_type, _args) do

    import Supervisor.Spec #supervisor helpers

    children = [worker(Hangman.Server, [])] #list of worker processes

    options = [
      name: Hangman.Supervisor,
      strategy: :simple_one_for_one #each process this supervisor is monitoring is independent
    ]

    Supervisor.start_link(children, options)
  end

end
