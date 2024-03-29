#!/usr/bin/julia

# Daniel "Trizen" Șuteu
# Date: 16 November 2021
# https://github.com/trizen

# https://projecteuler.net/problem=133

# Runtime: 1.137s

using Primes

function divisors(n)

    d = Int64[1]

    for (p,e) in factor(n)
        t = Int64[]
        r = 1

        for i in 1:e
            r *= p
            for u in d
                push!(t, u*r)
            end
        end

        append!(d, t)
    end

    return sort(d)
end

function prime_znorder(a, n)
    for d in divisors(n-1)
        if (powermod(a, d, n) == 1)
            return d
        end
    end
end

function p_133()

    factors = Dict{Int64, Nothing}()
    limit = 100_000

    N = 10^floor(Int64, log2(big(limit)))

    for p in primes(7, limit)
        if (rem(N, prime_znorder(10, p)) == 0)
            factors[p] = nothing
        end
    end

    total = 0
    for p in primes(limit)
        if !haskey(factors, p)
            total += p
        end
    end

    return total
end

println(p_133())
