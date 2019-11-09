#!/usr/bin/julia

# Daniel "Trizen" Șuteu
# Date: 19 October 2017
# https://github.com/trizen

# Runtime: 0.478s

# https://projecteuler.net/problem=191

using Memoize

function p_191(days::Int64)

    @memoize function generate(len, hasL, hasA1, hasA2)

        count = 0

        if (len == days)
            count += 1
        end

        if (len < days)

            if (!hasA1 || !hasA2)
                count += generate(len + 1, hasL, hasA2, true)
            end

            count += generate(len + 1, hasL, hasA2, false)

            if (!hasL)
                count += generate(len + 1, true, hasA2, false)
            end
        end

        return count
    end

    return generate(0, false, false, false)
end

println(p_191(30))
