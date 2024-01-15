#!/usr/bin/python

# Too Many Twos
# https://projecteuler.net/problem=792

# See also:
#   https://oeis.org/A059304

from math import comb

def nu_2(n):
    r = 0
    while n % 2 == 0:
        n //= 2
        r += 1
    return r

def S(n):
    result = 0
    for k in range(1, n + 1):
        result += (-2)**k * comb(2 * k, k)
    return result

def u(n):
    return nu_2(3 * S(n) + 4)

def U(N):
    return sum(u(n**3) for n in range(1, N + 1))

# Calculate U(10^4)
#result = U(10**4)
result = U(5)       #=> 241
print(result)

# U(10) = 3070
# U(16) = 18576
