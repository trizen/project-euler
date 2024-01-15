#!/usr/bin/python

# Asymmetric Diophantine Equation
# https://projecteuler.net/problem=764

from math import isqrt
from sympy import gcd

def generate_solutions(N):
    solutions = set()

    for y in range(1, isqrt(N) + 1):
        y_squared = y**2
        for x in range(1, isqrt(N // 4) + 1):
            x_squared = 16 * x**2
            z_squared = x_squared + y_squared**2
            z = isqrt(z_squared)
            if z**2 == z_squared and z <= N and gcd([x, y, z]) == 1:
                solutions.add((x, y, z))

    return solutions

def S(N):
    solutions = generate_solutions(N)
    return sum(sum(solution) for solution in solutions) % 10**9

# Calculate S(10^16) mod 10^9
result = S(10**4)   #=> 702 (wrong)
print(result)
