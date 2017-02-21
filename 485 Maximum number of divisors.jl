#!/usr/bin/julia

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 21 February 2017
# https://github.com/trizen

# https://projecteuler.net/problem=485

# Runtime: 7 min.

using Primes

@inline function sigma0(n)
    prod(map((v)-> 1+v, values(factor(n))))
end

function p485(r, n)

    divisors = map((k)->sigma0(k), 1:r)
    range_max = maximum(divisors)

    total = 0

    for i in r+1 : n+1
        total += range_max

        d = sigma0(i)
        if (d > range_max)
            range_max = d
        end

        append!(divisors, d)

        if (shift!(divisors) == range_max)
            range_max = maximum(divisors)
        end
    end

    return total
end

#println(p485(10, 1000))
println(p485(100_000, 100_000_000))
