#!/usr/bin/julia

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 02 May 2017
# https://github.com/trizen

# https://projecteuler.net/problem=581

# Runtime: ~8 seconds.

using Primes

function p_581()
    const smooth = 47
    const prime_nums = primes(smooth)

    function is_smooth(n)
        for p in prime_nums
            while (rem(n, p) == 0)
                n = div(n, p)
            end
        end

        n == 1
    end

    const seen = Dict{Int64,Bool}()
    const smooth_nums = Int64[1]

    sum = 0

    for p in prime_nums
        for n in smooth_nums
            if (!haskey(seen, n) && is_smooth(n+1))
                seen[n] = true
                sum += n
            end

            if (n*p <= 1109496723125)
                append!(smooth_nums, n*p)
            end
        end
    end

    return sum
end

println(p_581())
