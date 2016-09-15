#!/usr/bin/julia

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=78

# Runtime: 0.406s

function coin_partitions()
    n = 2
    p = [1]

    while(true)
        i = 0
        q = 2
        push!(p, 0)

        while q <= n
            p[n] += (i % 4 > 1 ? -1 : 1) * p[n-q+1]
            p[n] %= 1000000
            i += 1
            j = div(i, 2) + 1
            isodd(i) && (j *= -1)
            q = div(j * (3j - 1), 2) + 1
        end

        p[n] == 0 && break
        n += 1
    end

    n - 1
end

println(coin_partitions())
