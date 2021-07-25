#!/usr/bin/julia

# Daniel "Trizen" Șuteu
# Date: 05 June 2021
# https://github.com/trizen

# Stealthy Numbers
# https://projecteuler.net/problem=757

# These are numbers of the form x*(x+1) * y*(y+1), where x and y are positive integers.
# Also known as bipronic numbers.

# See also:
#   https://oeis.org/A072389

# WARNING: requires about 2GB of RAM!

# Runtime: ~15 seconds.

function p757(n::Int64)

    limit = trunc(n^(1/4))
    seen  = Dict{Int64, Nothing}()

    count = 0

    for x in 1:limit

        y = x
        while true
            v = x*(x+1)*y*(y+1)
            v > n && break

            if !haskey(seen, v)
                count += 1
                seen[v] = nothing
            end

            y += 1
        end
    end

    return count
end

println(p757(10^14))
