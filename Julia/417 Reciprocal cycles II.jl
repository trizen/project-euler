#!/usr/bin/julia

# Daniel "Trizen" Șuteu
# Date: 16 November 2021
# https://github.com/trizen

# Reciprocal cycles II
# https://projecteuler.net/problem=417

# Runtime: 9 minutes, 12 seconds

# Simple solution, by removing any divisibility by 2 and 5 from n, then:
#   L(n) = znorder(10, n)

# Optimization: iterate over the odd integers k and ingore multiples of 5.

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

function p_417()

    total = 0
    limit = 100_000_000

    for k in 3:2:limit

        rem(k, 5) == 0 && continue
        smooth = [k]

        for p in [2,5]
            for n in smooth
                if (n*p <= limit)
                    push!(smooth, n*p)
                end
            end
        end

        total += length(smooth) * znorder(10, k)
    end

    return total
end

println(p_417())
