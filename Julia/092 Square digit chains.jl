#!/usr/bin/julia

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 30 January 2017
# https://github.com/trizen

# https://projecteuler.net/problem=92

# Runtime: 2.405s

const cache = zeros(Int64, 10^7)

cache[ 1] = 1
cache[89] = 89

function chain(n::Int64)
    if (cache[n] == 0)
        cache[n] = chain(sum(map((d)->d^2, digits(n))))
    else
        cache[n]
    end
end

function count()
    c = 0
    for n in 1:10^7
        if (chain(n) == 89)
            c += 1
        end
    end
    return c
end

println(count())
