#!/usr/bin/julia

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 03 May 2017
# https://github.com/trizen

# https://projecteuler.net/problem=68

# Runtime: 1.532s

using Combinatorics

function isOK(d)
    if (
        d[1] < d[4]  &&
        d[1] < d[6]  &&
        d[1] < d[8]  &&
        d[1] < d[10]
    )
        i = d[1]  + d[2] + d[3]
        j = d[4]  + d[3] + d[5]
        k = d[6]  + d[5] + d[7]
        l = d[8]  + d[7] + d[9]
        m = d[10] + d[9] + d[2]

        i == j && i == k &&
        i == l && i == m
    else
        false
    end
end

function makeStr(d)
    string(d[1],d[2],d[3],d[4],d[3],d[5],d[6],d[5],d[7],d[8],d[7],d[9],d[10],d[9],d[2])
end

function p_68()
    max = ""
    nums = [i for i = 1:10]
    for j in 1:factorial(length(nums))
        perm = nthperm(nums, j)
        if isOK(perm)
            max = maximum([max, makeStr(perm)])
        end
    end
    return max
end

println(p_68())
