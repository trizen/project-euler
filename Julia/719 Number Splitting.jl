#!/usr/bin/julia

# Daniel "Trizen" Șuteu
# Date: 01 July 2020
# https://github.com/trizen

# Number Splitting
# https://projecteuler.net/problem=719

# Runtime: 9 min, 15 sec

function isok(i::Int64, j::Int64, d::Array{Int64}, e::Int64, n::Int64, sum::Int64 = 0)

    if (sum + parse(Int64, join(d[i:e])) < n)
        return false
    end

    new_sum = sum + parse(Int64, join(d[i:j]))

    if (new_sum > n)
        return false
    end

    if (new_sum == n && j >= e)
        return true
    end

    if (j+1 <= e)
        isok(j+1, j+1, d, e, n, new_sum) && return true
        isok(i,   j+1, d, e, n, sum)     && return true
    end

    return false
end

function p719(upto::Int64)
    sum = 0
    for n in (2:upto)
        d = reverse(digits(n*n))
        if (isok(1, 1, d, length(d), n))
            println(n*n)
            sum += n*n
        end
    end
    return sum
end

println("Total: ", p719(10^6))
