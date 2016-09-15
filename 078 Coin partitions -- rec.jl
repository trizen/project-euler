#!/usr/bin/julia

# Author: Daniel "Trizen" Șuteu
# Date: 19 August 2016
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=78

# Runtime: 1.526s

function partitions_count(n::Int64, mod::Int64, cache)

    if haskey(cache, n)
        return cache[n]
    end

    n <= 1 && return n

    sum_1 = 0
    for i in 1:Int64(floor((sqrt(24*n + 1) + 1)/6))
        sum_1 += ((-1)^(i-1) * partitions_count(n - div(i*(3*i - 1), 2), mod, cache)) % mod
    end

    sum_2 = 0
    for i in 1:Int64(ceil((sqrt(24*n + 1) - 7)/6))
        sum_2 += ((-1)^(i-1) * partitions_count(n - div((-i) * (-3*i - 1), 2), mod, cache)) % mod
    end

    x = (sum_1 + sum_2) % mod
    cache[n] = x
    x
end

n = 1
cache = Dict{Int64, Int64}()

while true
    if partitions_count(n, 1_000_000, cache) == 0
        println(n-1)
        break
    end
    n += 1
end
