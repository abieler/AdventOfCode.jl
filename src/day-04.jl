function day_04(filename::String)
    lines = readlines(open(filename))
    score = 0
    winningcards = DefaultDict{Int,Int}(1)
    for line in lines
        cardnr, winning, yours = collect(map(paresenumbers, split(line, r"[|:]")))
        cardnr = collect(cardnr)[1]
        nwins = length(intersect(winning, yours))
        score += nwins > 0 ? (2^(nwins - 1)) : 0
        if nwins > 0
            for i in (cardnr+1):(cardnr+nwins)
                winningcards[i] += winningcards[cardnr]
            end
        else
            winningcards[cardnr] += 0
        end

    end
    score, sum(collect(values(winningcards)))
end

function paresenumbers(text)
    [parse(Int, m.match) for m in eachmatch(r"\d+", text)]
end
