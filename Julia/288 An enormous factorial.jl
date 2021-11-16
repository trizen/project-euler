#!/usr/bin/julia

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 15 September 2016
# Website: https://github.com/trizen

# https://projecteuler.net/problem=288

# Runtime: 0.928s

const p = 61
const q = 10^7
const k = 10
const mod = 61^k

function fpower(n)
    n == 0 ? 0 : powermod(p, n-1, mod) + fpower(n-1)
end

function solve()
    s = 290797

    sum = 0
    pow = 0

    for n in 0:q
        t = s % p
        s = powermod(s, 2, 50515093)

        if n <= k
            pow = fpower(n)
        end

        sum += pow * t
        sum %= mod
    end

    return sum
end

println(solve())
