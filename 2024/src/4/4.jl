using BenchmarkTools
using StaticArrays

function alldirections()
    return Dict{String,CartesianIndex{2}}(
        "left" => CartesianIndex(-1, 0),
        "right" => CartesianIndex(1, 0),
        "up" => CartesianIndex(0, 1),
        "down" => CartesianIndex(0, -1),
        "upleft" => CartesianIndex(-1, 1),
        "upright" => CartesianIndex(1, 1),
        "downleft" => CartesianIndex(-1, -1),
        "downright" => CartesianIndex(1, -1)
    )
end

function countxmas(CM, directions)
    N, M = size(CM)
    cnt = 0
    word = @MArray ['X', '.', '.', '.']
    xmas = @SArray ['X', 'M', 'A', 'S']
    pos = CartesianIndex(0, 0)
    for idx in CartesianIndices(CM)
        if CM[idx] != 'X'
            continue
        end
        for direction in values(directions)
            word[2:4] .= '.'
            @inbounds for l = 1:3
                pos = idx + (l * direction)
                if (pos[1] > N) || (pos[2] > M) || (pos[1] < 1) || (pos[2] < 1)
                    break
                else
                    word[l+1] = CM[pos]
                end
            end
            if word == xmas
                cnt += 1
            end
        end
    end
    return cnt
end


filename = "input.txt"
data = filename |> readlines .|> l -> reduce(hcat, l)
charmatrix = vcat(data...)
directions = alldirections()
@benchmark countxmas(charmatrix, directions)

