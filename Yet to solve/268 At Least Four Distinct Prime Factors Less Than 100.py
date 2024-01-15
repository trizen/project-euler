#!/usr/bin/python

# At Least Four Distinct Prime Factors Less Than 100
# https://projecteuler.net/problem=268

from sympy import primerange, lcm, prod
from itertools import combinations

def count_divisible_numbers(limit, max_primes):
    primes = list(primerange(1, max_primes + 1))

    total_count = 0
    for k in range(4, len(primes) + 1):
        print(k)
        for prime_combination in combinations(primes, k):
            lcm_value = prod(list(prime_combination))
            total_count += limit // lcm_value

    return total_count

limit = 10**16 - 1
max_primes = 100

result = count_divisible_numbers(limit, max_primes)
print(result)       #=> 2304177487018306 (however, it's wrong)
