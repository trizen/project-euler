#!/usr/bin/julia

# Daniel "Trizen" Șuteu
# Date: 01 July 2020
# https://github.com/trizen

# Number Splitting
# https://projecteuler.net/problem=719

# Runtime: 2.720s

function isok(n::Int64, m::Int64)

    (m  < n) && return false
    (m == n) && return true

    t = 10
    while (t < m)
        q,r = divrem(m, t)
        (r < n) && isok(n - r, q) && return true
        t *= 10
    end

    return false
end

function p719(upto)
    total = 0

    for n in 2:upto
        if isok(n, n*n)
            total += n*n
        end
    end

    return total
end

println(p719(10^6))
