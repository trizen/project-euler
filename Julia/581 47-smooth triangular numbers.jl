#!/usr/bin/julia

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 02 May 2017
# Edit: 28 June 2019
# https://github.com/trizen

# https://projecteuler.net/problem=581

# Runtime: 4.153s.

using Primes

function p_581()

    smooth = 47
    limit  = 1109496723125       # A002072(π(47)) = A002072(15)

    prime_nums = primes(smooth)
    smooth_prod = prod(prime_nums)

    function is_smooth_over_prod(n,k)

        g = gcd(n, k)

        while (g > 1)
            while (rem(n, g) == 0)
                n = div(n, g)
            end
            n == 1 && return true
            g = gcd(n, k)
        end

        n == 1
    end

    smooth_nums = Int64[1]

    for p in prime_nums
        for n in smooth_nums
            if (n*p <= limit)
                append!(smooth_nums, n*p)
            end
        end
    end

    total = 0

    for n in (smooth_nums)
        if (is_smooth_over_prod(n+1, smooth_prod))
            total += n
        end
    end

    return total
end

println(p_581())
