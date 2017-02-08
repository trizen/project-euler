#!/usr/bin/julia

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 08 February 2017
# https://github.com/trizen

# https://projecteuler.net/problem=96

# Runtime: 5.685s

function check(i, j)
    id, im = div(i, 9), mod(i, 9)
    jd, jm = div(j, 9), mod(j, 9)

    jd == id && return true
    jm == im && return true

    div(id, 3) == div(jd, 3) &&
    div(jm, 3) == div(im, 3)
end

const lookup = zeros(Bool, 81, 81)

for i in 1:81
    for j in 1:81
        lookup[i,j] = check(i-1, j-1)
    end
end

function solve_sudoku(callback::Function, grid::Array{Int64})
    function solve()
        for i in 1:81
            if grid[i] == 0
                t = Dict{Int64, Bool}()

                for j in 1:81
                    if lookup[i,j]
                        t[grid[j]] = true
                    end
                end

                for k in 1:9
                    if !haskey(t, k)
                        grid[i] = k
                        solve()
                    end
                end

                grid[i] = 0
                return()
            end
        end
        callback(grid)
    end
    solve()
end

function euler_096()

    fh = open("p096_sudoku.txt")
    lines = filter((x)->ismatch(r"^[0-9]+$",x), readlines(fh))

    total = 0

    while length(lines) > 0
        grid = splice!(lines, 1:9)
        grid = map((c)->parse(Int64, c), split(join(map(chomp, grid)), ""))
        solve_sudoku((s)->(total += s[1]*100 + s[2]*10 + s[3]), grid)
    end

    println(total)
end

euler_096()
