using BenchmarkTools

function getdirections()
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

function countxmas(C, directions)
    N, M = size(C)
    cnt = 0
    word = ['X', '.', '.', '.']
    xmas = ['X', 'M', 'A', 'S']
    pos = CartesianIndex(0, 0)
    for idx in CartesianIndices(C)
        if C[idx] != 'X'
            continue
        end
        for (name, ddir) in directions
            word[2:4] .= '.'
            @inbounds for l = 1:3
                pos = idx + (l * ddir)
                if (pos[1] > N) || (pos[2] > M) || (pos[1] < 1) || (pos[2] < 1)
                    break
                else
                    word[l+1] = C[pos]
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
charmatrix = filename |> readlines .|> l -> reduce(hcat, l)
C = vcat(charmatrix...)
directions = getdirections()
@benchmark countxmas(C, directions)

