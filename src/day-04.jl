function day_04_01(filename::String)
    lines = readlines(open(filename))
    score = 0
    winningcards = DefaultDict{Int,Int}(0)
    for line in lines
        cardnr, winning, yours = collect(map(paresenumbers, split(line, r"[|:]")))
        nwins = length(intersect(winning, yours))
        score += nwins > 0 ? (2^(nwins - 1)) : 0
    end
    score
end

function day_04_02(filename::String)
    lines = readlines(open(filename))
    cardnr, winning, yours = collect(map(paresenumbers, split(line, r"[|:]")))

end

function paresenumbers(text)
    Set([parse(Int, m.match) for m in eachmatch(r"\d+", text)])
end
