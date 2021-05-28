defmodule Dictionary.Application do

  use Application #sets up default settings for Elixir app

  #callback that starts the application process
  def start(_type, _args) do

    import Supervisor.Spec #supervisor helpers

    #Dictionary.WordList.start_link()

    children = [worker(Dictionary.WordList, [])] #list of worker processes

    options = [
      name: Dictionary.Supervisor,
      strategy: :one_for_one #each process this supervisor is monitoring is independent
    ]

    Supervisor.start_link(children, options)
  end

end
