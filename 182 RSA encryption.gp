
\\ Pari/GP

p = 1009
q = 3643

s = 0
P = (p-1) * (q-1)

for(e = 2, P-1, if(gcd(e, P) == 1 && gcd(e-1, p-1) == 2 && gcd(e-1, q-1) == 2, s += e))

print(s)
