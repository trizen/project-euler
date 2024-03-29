#!/usr/bin/julia

# Daniel "Trizen" Șuteu
# Edit: 25 July 2021
# https://github.com/trizen

# Find the value of d < 1000 for which 1/d contains the longest recurring cycle in its decimal fraction part.

# https://projecteuler.net/problem=26

# Runtime: 1.014s

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

function p_26()
    d,m = 1,0

    for n in 2:1000

        gcd(10, n) == 1 || continue
        r = znorder(10, n)

        if (r > m)
            m,d = r,n
        end
    end

    return d
end

println(p_26())
