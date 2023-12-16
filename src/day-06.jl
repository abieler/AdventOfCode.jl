function day_06(filename::String; day=1)
    lines = readlines(open(filename))
    racetime = [parse(Int, m.match) for m in eachmatch(r"\d+", lines[1])]
    records = [parse(Int, m.match) for m in eachmatch(r"\d+", lines[2])]
    if day == 2
        racetime = [parse(Int, join([string(t) for t in racetime], ""))]
        records = [parse(Int, join([string(t) for t in records], ""))]
    end

    result = []
    for (t, r) in zip(racetime, records)
        N = length(filter(x->x>r, traveldistances(t)))
        push!(result, N)
    end
    prod(result)
end

traveldistances(racetime) =  [t * (racetime-t) for t in 1:racetime-1]
