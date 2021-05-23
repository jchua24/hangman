defmodule Lists do 

    def map([], _func), do: []

    def map([h | t], func) do
        [func.(h) | map(t, func)] 
    end

    def sum_pairs([]), do: []

    def sum_pairs([h1, h2 | t]), do: [h1 + h2 | sum_pairs(t)]

end 