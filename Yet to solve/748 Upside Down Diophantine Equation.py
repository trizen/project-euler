#!/usr/bin/python

# Upside down Diophantine equation
# https://projecteuler.net/problem=748

from math import isqrt

def generate_primitive_solutions(N):
    solutions = set()

    for m in range(1, isqrt(N // 13) + 1):
        square_root_13_m_squared = isqrt(13) * m
        for x in range(1, square_root_13_m_squared + 1):
            if square_root_13_m_squared % x == 0:
                y = square_root_13_m_squared // x
                z_squared = 13 * x**2 * y**2
                if z_squared <= N:
                    solutions.add((x, y, isqrt(z_squared)))

    return solutions

def S(N):
    primitive_solutions = generate_primitive_solutions(N)
    return sum(sum(solution) for solution in primitive_solutions)

# Calculate S(10^16) mod 10^9
#result = S(10**16) % 10**9
result = S(10**5) % 10**9       #=> 37765 (wrong)
print(result)
