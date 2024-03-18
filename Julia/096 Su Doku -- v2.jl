#!/usr/bin/julia

# Author: Trizen
# Date: 12 February 2024
# https://github.com/trizen

# https://projecteuler.net/problem=96

# Runtime: 1.023s

function is_valid(board, row, col, num)
    # Check if the number is not present in the current row and column
    for i in 1:9
        if (board[row][i] == num) || (board[i][col] == num)
            return false
        end
    end

    # Check if the number is not present in the current 3x3 subgrid
    start_row, start_col = 3*div(row-1, 3), 3*div(col-1, 3)
    for i in 1:3, j in 1:3
        if board[start_row + i][start_col + j] == num
            return false
        end
    end

    return true
end

function find_empty_locations(board)

    positions = []

    # Find all empty positions (cells with 0)
    for i in 1:9, j in 1:9
        if board[i][j] == 0
            push!(positions, [i, j])
        end
    end

    return positions
end

function find_empty_location(board)

    # Find an empty positions (cell with 0)
    for i in 1:9, j in 1:9
        if board[i][j] == 0
            return [i,j]
        end
    end

    return (nothing, nothing)
end

function solve_sudoku_fallback(board)

    row, col = find_empty_location(board)

    if (row == nothing && col == nothing)
        return true  # Puzzle is solved
    end

    for num in 1:9
        if is_valid(board, row, col, num)
            # Try placing the number
            board[row][col] = num

            # Recursively try to solve the rest of the puzzle
            if solve_sudoku_fallback(board)
                return true
            end

            # If placing the current number doesn't lead to a solution, backtrack
            board[row][col] = 0
        end
    end

    return false  # No solution found
end

function solve_sudoku(board)

    while true

        # Return early when the first 3 values are solved
        if board[1][1] != 0 && board[1][2] != 0 && board[1][3] != 0
            return board
        end

        empty_locations = find_empty_locations(board)

        if length(empty_locations) == 0
            break   # it's solved
        end

        found = false

        # Solve easy cases
        for (i,j) in empty_locations
            count = 0
            value = 0
            for n in 1:9
                if is_valid(board, i, j, n)
                    count += 1
                    value = n
                    count > 1 && break
                end
            end
            if count == 1
                board[i][j] = value
                found = true
            end
        end

        found && continue

        # Solve more complex cases
        stats = Dict{String,Array}()
        for (i,j) in empty_locations
            arr = []
            for n in 1:9
                if is_valid(board, i, j, n)
                    append!(arr, n)
                end
            end
            stats["$i $j"] = arr
        end

        cols    = Dict{String,Int}()
        rows    = Dict{String,Int}()
        subgrid = Dict{String,Int}()

        for (i,j) in empty_locations
            for v in stats["$i $j"]

                k1 = "$j $v"
                k2 = "$i $v"
                k3 = join([3*div(i-1,3), 3*div(j-1,3), v], " ")

                if !haskey(cols, k1)
                    cols[k1] = 1
                else
                    cols[k1] += 1
                end

                if !haskey(rows, k2)
                    rows[k2] = 1
                else
                    rows[k2] += 1
                end

                if !haskey(subgrid, k3)
                    subgrid[k3] = 1
                else
                    subgrid[k3] += 1
                end
            end
        end

        for (i,j) in empty_locations
            for v in stats["$i $j"]
                if (cols["$j $v"] == 1 ||
                    rows["$i $v"] == 1 ||
                    subgrid[join([3*div(i-1,3), 3*div(j-1,3), v], " ")] == 1)
                    board[i][j] = v
                    found = true
                end
            end
        end

        found && continue

        # Give up and try brute-force
        solve_sudoku_fallback(board)
        return board
    end

    return board
end

function euler_096()

    fh = open("p096_sudoku.txt")
    lines = filter((x)->occursin(r"^[0-9]+$",x), readlines(fh))

    total = 0

    while length(lines) > 0
        rows = splice!(lines, 1:9)
        grid = map((row) -> map((c)->parse(Int64, c), split(row, "")), rows)
        solution = solve_sudoku(grid)
        total += solution[1][1]*100 + solution[1][2]*10 + solution[1][3]
    end

    println(total)
end

euler_096()
