#!/usr/bin/julia

# Author: Daniel "Trizen" Șuteu
# Date: 18 August 2016
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=75

function count_singular_triples(limit::Int64)

    triangle = Dict{Int64, Int64}()
    upto = isqrt(limit)

    for n in 1:upto-1
        for m in n+1:2:upto
            if gcd(n, m) == 1
                k = 1
                while true
                    x = k * (m^2 - n^2)
                    y = k * (2 * m * n)
                    z = k * (m^2 + n^2)

                    p = x + y + z
                    p > limit && break

                    if !haskey(triangle, p)
                        triangle[p] = 1
                    else
                        triangle[p] += 1
                    end

                    k += 1
                end
            end
        end
    end

    count = 0
    for v in values(triangle)
        v == 1 && (count += 1)
    end

    count
end

println(count_singular_triples(1_500_000))
