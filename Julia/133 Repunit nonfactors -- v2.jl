#!/usr/bin/julia

# Daniel "Trizen" Șuteu
# Date: 16 November 2021
# https://github.com/trizen

# https://projecteuler.net/problem=133

# Runtime: 1.220s

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

function znorder(a, n)

    if isprime(n)
        for d in divisors(n-1)
            if (powermod(a, d, n) == 1)
                return d
            end
        end
    end

    f = factor(n)

    if (length(f) == 1)         # is prime power
        p = first(first(f))
        z = znorder(a, p)

        while (powermod(a, z, n) != 1)
            z *= p
        end

        return z
    end

    pp_orders = Int64[]

    for (p,e) in f
        push!(pp_orders, znorder(a, p^e))
    end

    return lcm(pp_orders)
end

function p_133()

    factors = Dict{Int64, Nothing}()
    limit = 100_000

    N = 10^floor(Int64, log2(big(limit)))

    for p in primes(7, limit)
        if (rem(N, znorder(10, p)) == 0)
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
