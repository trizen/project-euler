#!/usr/bin/julia

# Author: Daniel "Trizen" Șuteu
# Date: 16 August 2016
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=74

fac = Int64[factorial(i) for i in 0:9]

function f(n::Int64, fac)

    seen = Dict{Int64,Bool}(n => true)

    while true
        m = sum(Int64[fac[i+1] for i in digits(n)])
        haskey(seen, m) && break
        seen[m] = true
        n = m
    end

    length(seen) == 60
end

function count(limit)
    c = 0

    for i in 0:limit-1
        f(i, fac) && (c += 1)
    end

    return c
end

println(count(1_000_000))
