NUMBERS = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
VALUE_MAP = Dict(w => string(i) for (i, w) in enumerate(NUMBERS))
PATTERNS = Dict{Int,Regex}(1 => r"[0-9]", 2 => Regex("[0-9]|$(join(NUMBERS, "|"))"))

parsedata(data) = map(parsematch, eachmatch(PATTERNS[data.day], data.line, overlap = true))
parsedigits(digits) = parse(Int, "$(digits[1])$(digits[end])")
parsematch(m) = length(m.match) == 1 ? m.match : VALUE_MAP[m.match]

function day_01(filename::String; day::Integer)
    data = [(line = l, day = day) for l in readlines(open(filename, "r"))]
    data .|> parsedata .|> parsedigits |> sum
end
