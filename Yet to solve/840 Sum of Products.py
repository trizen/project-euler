from sympy import primerange, isprime, factorint

def D(n, memo):
    if n == 1:
        return 1
    if isprime(n):
        return 1

    if n in memo:
        return memo[n]

    # Factorize n into p and q
    factors = factorint(n)
    p = list(factors.keys())[0]
    q = n//p

    result = D(p, memo) * q + p * D(q, memo)
    memo[n] = result
    return result

def G(partition):
    result = 1
    for a_j in partition:
        result *= D(a_j, {})
    return result

def S(N, mod):
    total_sum = 0

    for n in range(1, N + 1):
        partitions = generate_partitions(n)
        for partition in partitions:
            total_sum += G(partition)

    return total_sum % mod

def generate_partitions(n):
    def partition(n, I=1):
        yield (n,)
        for i in range(I, n//2 + 1):
            for p in partition(n-i, i):
                yield (i,) + p

    return list(partition(n))

# Calculate S(5 * 10^4) % 999676999
#result = S(5 * 10**4, 999676999)
result = S(10, 999676999)
print(result)
