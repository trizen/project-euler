#!/usr/bin/julia

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 14 May 2017
# https://github.com/trizen

# https://projecteuler.net/problem=133

# Runtime: 2 min, 5 sec

using Primes

function p_133()
    factors = Dict{Int64, Bool}()
    limit = 100_000

    p = 10
    while (p < limit)
        p += 1
        isprime(p) || continue

        k,s,P = 0,0,0

        while (k <= p)
            s += powermod(10, k, p)
            s %= p
            P += 1
            s == 0 && break
            k += 1
        end

        if (s == 0 && powermod(10, k, P) == 0)
            factors[p] = true
            println("$p is a prime factor (period: $P)")
        end
    end

    return sum(filter((p) -> !haskey(factors, p), primes(limit)))
end

println(p_133())
