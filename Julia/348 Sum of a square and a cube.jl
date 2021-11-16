#!/usr/bin/julia

# Daniel "Trizen" Șuteu
# Date: 20 February 2017
# License: GPLv3
# https://github.com/trizen

# https://projecteuler.net/problem=348

# Runtime: 15.005s

function p348(n)

    count = Dict{Int64, Int64}()
    total = 0

    for i in 1:2^32
        for j in 1:(i>>2)
            s = i^2
            c = j^3
            p = s+c

            if (string(p) == reverse(string(p)))
                if haskey(count, p)
                    count[p] += 1
                else
                    count[p] = 1
                end

                if (count[p] == 4)
                    total += p
                    n -= 1
                end
            end
        end
        n == 0 && break
    end

    return total
end

println("Sum: ", p348(5))
