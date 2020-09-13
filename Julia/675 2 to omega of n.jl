#!/usr/bin/julia

# Daniel "Trizen" Șuteu
# Date: 27 June 2019
# https://github.com/trizen

# Based on the identity:
#   Sum_{d|n} 2^omega(d) = sigma_0(n^2)

# The algorithm iteraters over each number in k = 1..N,
# and computes sigma_0(k^2) = Prod_{p^e | k} (2*e + 1).

# By keeping track of the partial products, we find sigma_0(k!^2).

# Runtime: ~21.374s

# https://projecteuler.net/problem=675

using Primes
using Printf

function F(N::Int64, MOD::Int64)

    table   = Dict{Int64,Int64}()
    total   = 0
    partial = 1

    function mulmod(a,b)
        (a * b) % MOD
    end

    for k in 2:N

        old = 1   # old product

        for (p,e) in factor(k)
            if haskey(table, p)
                old = mulmod(old, 2*table[p] + 1)
            else
                table[p] = 0
            end
            table[p] += e
            partial = mulmod(partial, 2*table[p] + 1)
        end

        partial = mulmod(partial, invmod(old, MOD))    # remove the old product
        total += partial
        total %= MOD
    end

    return total
end

const MOD = 1000000087

for n in 1:7
    @printf("F(10^%d) = %10d (mod %d)\n", n, F(10^n, MOD), MOD)
end
