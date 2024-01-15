#!/usr/bin/python

# Upside down Diophantine equation
# https://projecteuler.net/problem=748

from math import isqrt

def generate_primitive_solutions(N):
    solutions = set()

    for v in range(1, isqrt(N // 13) + 1):
        v_squared_13 = v**4 * 13
        for x in range(1, isqrt(v_squared_13) + 1):
            if v_squared_13 % x == 0:
                y_squared = v_squared_13 // x
                x_squared_plus_y_squared = x**2 + y_squared
                if x_squared_plus_y_squared <= N:
                    z_squared = x**2 * y_squared // x_squared_plus_y_squared
                    z = isqrt(z_squared)
                    solutions.add((x, isqrt(y_squared), z))

    return solutions

def S(N):
    primitive_solutions = generate_primitive_solutions(N)
    return sum(sum(solution) for solution in primitive_solutions)

# Calculate S(10^16) mod 10^9
#result = S(10**16) % 10**9
result = S(10**5) % 10**9   #=> 79635 (wrong)
print(result)
