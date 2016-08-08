#!/usr/bin/julia

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Website: https://github.com/trizen

@inline function is_csquare(n)
    s = isqrt(n)
    for i in 1:s-1
        sum = i^2
        for j in i+1:s
            sum += j^2
            sum > n && break
            sum == n && return true
        end
    end
    return false
end

count = 0
sum = 0

const limit = 100000000

for i in 1:9
    if is_csquare(i)
        count += 1
        sum += i
    end
end

i = 1
while true
    s = string(i)
    r = reverse(s)
    p = s * r
    k = parse(Int64, p)
    k >= limit && break

    if is_csquare(k)
        count += 1
        sum += k
    end

    for j in 0:9
        p = s * string(j) * r
        k = parse(Int64, p)
        k >= limit && break
        if is_csquare(k)
            count += 1
            sum += k
        end
    end
    i += 1
end

println("count: ", count)
println("sum: ", sum)
