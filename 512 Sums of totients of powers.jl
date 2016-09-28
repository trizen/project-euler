#!/usr/bin/julia

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 29 September 2016
# Website: https://github.com/trizen

# https://projecteuler.net/problem=512

# Runtime: pretty long

using Primes

@inline function eulerphi(n::Int64)

    for p in keys(factor(n))
        n -= div(n, p)
    end

    n
end

function g(n::Int64)

    sum = 0
    for k in 0:div(n, 2)-1
        sum += eulerphi(2*k + 1)
    end

    sum
end

println(g(5 * 10^8))
