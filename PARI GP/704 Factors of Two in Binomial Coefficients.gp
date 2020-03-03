\\ Pari/GP

\\ Daniel "Trizen" Șuteu
\\ Date: 03 March 2020
\\ https://github.com/trizen

\\ Factors of Two in Binomial Coefficients
\\ https://projecteuler.net/problem=704

\\ Runtime: 0.165s

A(n) = (n+1) * logint(n, 2) - 2*(2^logint(n,2) - 1);
B(n) = n - hammingweight(n);
S(n) = A(n+1) - B(n+1);

print(S(10^16));
