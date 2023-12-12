struct PartNumber
    uuid::String
    value::Integer
end

function day_03_01(filename::String)
    char_matrix = text_to_matrix(filename)
    partnr_matrix = Matrix{Union{Missing,PartNumber}}(missing, size(char_matrix))
    keep_only_part_numbers!(char_matrix, partnr_matrix)
    return sum([pn === missing ? 0 : pn.value for pn in Set(partnr_matrix)])
end

function day_03_02(filename::String)
    char_matrix = text_to_matrix(filename)
    nrows, ncols = size(char_matrix)
    partnr_matrix = Matrix{Union{Missing,PartNumber}}(missing, size(char_matrix))
    keep_only_part_numbers!(char_matrix, partnr_matrix)
    result = 0
    for irow = 1:nrows
        for icol = 1:ncols
            if char_matrix[irow, icol] != '*'
                continue
            else
                roi = regionofinterest(irow, [icol], nrows, ncols)
                adj_part_numbers = adjacentpartnumbers(partnr_matrix, roi)
                if length(adj_part_numbers) == 2
                    result += (adj_part_numbers[1].value * adj_part_numbers[2].value)
                end
            end
        end
    end
    result
end

function adjacentpartnumbers(partnr_matrix, roi)
    collect(Set(filter(pn -> pn !== missing, partnr_matrix[roi.rows, roi.cols])))
end

function text_to_matrix(filename)
    lines = readlines(open(filename))
    nrows = length(lines)
    ncols = length(lines[1])
    char_matrix = Matrix{Char}(undef, nrows, ncols)
    for (irow, line) in enumerate(lines)
        char_matrix[irow, :] = collect(strip(line))
    end
    return char_matrix
end


function keep_only_part_numbers!(char_matrix, partnr_matrix)
    nrows, ncols = size(char_matrix)
    irow = 1
    while irow <= nrows
        icol = 1
        while icol <= ncols
            if isdigit(char_matrix[irow, icol]) == false
                icol += 1
                continue
            end
            digit_idxs = consecutive_digits(irow, icol, char_matrix)
            roi = regionofinterest(irow, digit_idxs, nrows, ncols)
            if contains_symbol(char_matrix, roi)
                value = parse(Int, join(char_matrix[irow, digit_idxs], ""))
                uidx = string(uuid4())
                for i in digit_idxs
                    partnr_matrix[irow, i] = PartNumber(uidx, value)
                end
                icol += length(digit_idxs)
                continue
            else
                char_matrix[irow, digit_idxs] .= '.'
                icol += length(digit_idxs)
                continue
            end
            icol += 1
        end
        irow += 1
    end
end


function regionofinterest(irow, icols, nrows, ncols)
    (
        rows = max(1, irow - 1):min(irow + 1, nrows),
        cols = max(1, icols[1] - 1):min(icols[end] + 1, ncols),
    )
end

function consecutive_digits(irow, icol, char_matrix)
    idxs = [icol]
    for idx = icol+1:size(char_matrix, 2)
        if isdigit(char_matrix[irow, idx])
            push!(idxs, idx)
        else
            break
        end
    end
    idxs
end

issymbol(c::Char) = c != '.' && !isdigit(c) && true
contains_symbol(char_mask, roi) = sum(issymbol.(char_mask[roi.rows, roi.cols])) > 0
