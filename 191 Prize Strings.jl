#!/usr/bin/julia

# Daniel "Trizen" Șuteu
# Date: 17 October 2017
# https://github.com/trizen

# Runtime: ~7 minutes.

# https://projecteuler.net/problem=191

# For a faster solution, see version 2.

function p_191(days::Int64)

    count = 0

    function generate(solution, hasL)

        len = length(solution)

        if (len == days)
            count += 1
        end

        if (len < days)

            if (len >= 2)
                if (solution[len] != 'A' || solution[len-1] != 'A')
                    generate(solution * "A", hasL)
                end
            else
                generate(solution * "A", hasL)
            end

            generate(solution * "O", hasL)

            if (!hasL)
                generate(solution * "L", true)
            end
        end
    end

    generate("", false)
    return count
end

println(p_191(30))
