#!/usr/bin/julia

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 04 May 2017
# https://github.com/trizen

# https://projecteuler.net/problem=516

# Runtime: 1 min, 23 sec.

using Primes

function Φ(n::Int64)

    for p in keys(factor(n))
        n -= div(n, p)
    end

    n
end

function is_5_smooth(n::Int64)

    for p in [2,3,5]
        while (rem(n, p) == 0)
            n = div(n, p)
        end
    end

    n == 1
end

function p_516(limit::Int64 = 10^12)

    smooth = Int64[1]

    for p in [2,3,5]
        for n in smooth
            if (n*p <= limit)
                append!(smooth, n*p)
            end
        end
    end

    smooth = reverse(
        sort(
            filter((n)->isprime(n),
            map((n)->n+1, smooth))
        )
    )

    h   = Int64[1]
    mod = 1 << 32

    sum = 0
    for p in smooth
        for n in h
            if (p*n <= limit && is_5_smooth(Φ(n*p)))
                if (p == 2)
                    for n in h
                        while (n*p <= limit)
                            sum += (n*p) % mod
                            sum %= mod
                            n *= p
                        end
                    end
                    break
                else
                    sum += (n*p) % mod
                    sum %= mod
                    append!(h, n*p)
                end
            end
        end
        println("$p -> $sum")
    end

    return sum+1
end

println(p_516(10^12))
