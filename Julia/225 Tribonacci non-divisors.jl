#!/usr/bin/julia

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 06 May 2017
# https://github.com/trizen

# https://projecteuler.net/problem=225

# Runtime: 5.017s

function p_225(nth=124)

    a,c,k = 0,1,1

    while (c <= nth)
        cache = Dict{Int64, Int64}()

        function tribonacci(n)
            n <= 3 ? 1 :
            haskey(cache, n) ? cache[n] : cache[n] = (
                tribonacci(n - 1) % k
              + tribonacci(n - 2) % k
              + tribonacci(n - 3) % k
            ) % k
        end

        n = 4
        while true
            t1 = tribonacci(n)
            t2 = tribonacci(n+1)
            t3 = tribonacci(n+2)

            if (t1 == 1 && t2 == 1 && t3 == 1)
                a = k
                c += 1
                break
            end

            if (t1 == 0 || t2 == 0 || t3 == 0)
                break
            end

            n += 3
        end

        k += 2
    end

    return a
end

println(p_225())
