#!/usr/bin/julia

# Daniel "Trizen" Șuteu
# Date: 16 November 2021
# https://github.com/trizen

# https://projecteuler.net/problem=132

# Runtime: 1.133s

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

function p_132()

    N = 1e9
    C = 40

    count = 0
    total = 0

    p = 7
    while true
        if (rem(N, prime_znorder(10, p)) == 0)
            total += p
            count += 1
            count >= C && break
        end
        p = nextprime(p+1)
    end

    return total
end

println(p_132())
