#!/usr/bin/julia

# Daniel "Trizen" Șuteu
# Date: 04 July 2018
# https://github.com/trizen

# https://projecteuler.net/problem=565

# Runtime: ~18 minutes

using Primes

function divisor_sum(n)
    sigma = 1
    for (p,e) in factor(n)
        s = 1
        for j in 1:e
            s += p^j
        end
        sigma *= s
    end
    sigma
end

function S(n::Int64, k::Int64)

    total = 0
    seen = Dict{Int64,Bool}()

    function process_term(t::Int64)

        for s in t:t:n

            if (s % (t*t) == 0)
                continue
            end

            if (divisor_sum(div(s,t)) % k == 0)
                if (haskey(seen, s))
                    continue
                else
                    seen[s] = true
                end
            end

            if (divisor_sum(s) % k == 0)
                total += s
            end
        end
    end

    p = 2
    isqrtn = isqrt(n)

    while (p <= isqrtn)

        for e in 3 : 1+Int64(floor(log(p, n)))
            if ((p^e - 1) % k == 0)
                process_term(p^(e-1))
            end
        end

        p = nextprime(p+1)
    end

    for t in k:k:n
        if (isprime(t - 1))
            process_term(t - 1)
        end
    end

    total
end

println(S(10^6,  2017))
println(S(10^9,  2017))
println(S(10^11, 2017))
