function day_02(filename::String)
    lines = readlines(open(filename, "r"))
    bag = (red = 12, green = 13, blue = 14)
    score = 0
    power = 0
    for (gameid, line) in enumerate(lines)
        gameresults = [parsegame(game) for game in split(line[8:end], ";")]
        if all(isvalid(r, bag) for r in gameresults)
            score += gameid
        end
        minbag = minimalbag(gameresults)
        power += (minbag.red * minbag.blue * minbag.green)
    end
    return score, power
end

function parsegame(game)
    red =
        match(r"(\d+) red", game) === nothing ? 0 :
        parse(Int, match(r"(\d+) red", game).captures[1])
    blue =
        match(r"(\d+) blue", game) === nothing ? 0 :
        parse(Int, match(r"(\d+) blue", game).captures[1])
    green =
        match(r"(\d+) green", game) === nothing ? 0 :
        parse(Int, match(r"(\d+) green", game).captures[1])
    (green = green, blue = blue, red = red)
end

function isvalid(gameresult, bag)
    (gameresult.red <= bag.red) &&
        (gameresult.blue <= bag.blue) &&
        (gameresult.green <= bag.green)
end

function minimalbag(gameresults)
    green = max([r.green for r in gameresults]...)
    blue = max([r.blue for r in gameresults]...)
    red = max([r.red for r in gameresults]...)
    (green = green, blue = blue, red = red)
end
