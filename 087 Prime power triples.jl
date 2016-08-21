#!/usr/bin/julia

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=87

limit = 50_000_000
max = isqrt(limit)
primes = Int64[2]

for i in 1:2:max
    isprime(i) && push!(primes, i)
end

function count_primes(primes, limit)

    seen = Dict{Int64, Bool}()
    len = length(primes)
    count = 0

    for p in primes
        for j in 1:len
            p^2 + primes[j]^3 < limit || break
            for k in 1:len
                n = p^2 + primes[j]^3 + primes[k]^4
                n < limit || break
                if !haskey(seen, n)
                    seen[n] = true
                    count += 1;
                end
            end
        end
    end

    count
end

println(count_primes(primes, limit))
