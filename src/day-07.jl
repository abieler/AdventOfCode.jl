Cards = Dict(
    1 => Dict{Char,Int}(s => v for (v, s) in enumerate(collect("23456789TJQKA"))),
    2 => Dict{Char,Int}(s => v for (v, s) in enumerate(collect("J23456789TQKA")))
)

function day_07(filename; day=1)
    lines = readlines(open(filename))
    data = [parseline(l, day=day) for l in lines]

    result = 0
    for (rank, data) in enumerate(sort(data, lt=islowerhand))
        result += rank * data.bid
    end
    return result
end

function parseline(l; day=1)
    hand = split(l, " ")[1]
    bid = parse(Int, split(l, " ")[2])
    orderedhand = orderhand(hand, day=day)
    day = day
    return (hand=hand, bid=bid, orderedhand=orderedhand, day=day)
end

function orderhand(h; day=1)
    oh = sort(h |> counter |> collect, by=x -> (x.second, x.first), rev=true) |> OrderedDict
    (day == 1 || !contains(h, 'J')) && return oh

    nJs = pop!(oh, 'J')
    if length(oh) == 0
        oh['A'] = length(collect(h)) # if JJJJJ -> AAAAA
        return oh
    end
    best = collect(keys(oh))[1]
    oh[best] += nJs
    return oh
end

function islowerhand(h1, h2)
    # check if one hand is of higher rank than other
    for (p1, p2) in zip(pairs(h1.orderedhand), pairs(h2.orderedhand))
        if p1.second < p2.second
            return true
        elseif p1.second > p2.second
            return false
        end
    end

    # compare first card value
    for (c1, c2) in zip(collect(h1.hand), collect(h2.hand))
        c1 != c2 && return Cards[h1.day][c1] < Cards[h2.day][c2]
    end
    return false
end
