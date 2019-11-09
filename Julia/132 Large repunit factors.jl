#!/usr/bin/julia

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 14 May 2017
# https://github.com/trizen

# https://projecteuler.net/problem=132

# Runtime: 6 min, 14 sec

using Primes

function p_132()

    count = 40
    n = 10^9

    p = 1
    t = 0

    while true
        p += 1

        isprime(p)     || continue
        gcd(n, p) == 1 || continue

        sum = 0
        period = 0

        for k in 0:p
            sum += powermod(10, k, p)
            sum %= p
            period += 1
            sum == 0 && break
        end

        if (sum == 0 && n % period == 0)
            t += p
            println("[$count] $p is a prime factor -> $t")
            count -= 1
            count == 0 && break
        end
    end

    return t
end

println(p_132())
