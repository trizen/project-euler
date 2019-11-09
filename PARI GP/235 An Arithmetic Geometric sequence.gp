
\\ Daniel "Trizen" Șuteu
\\ License: GPLv3
\\ Date: 27 September 2017
\\ https://github.com/trizen

\\ https://projecteuler.net/problem=235

\\
\\ s(n) = sum((900-3k)*x^(k-1), {k=1..n})
\\
\\ We can easily derive a closed-form using Wolfram|Alpha:
\\      http://www.wolframalpha.com/input/?i=sum((900-3k)*r%5E(k-1),+%7Bk%3D1..n%7D)
\\
\\ we get:
\\      s(n) = (-3 * (n - 300) * x^(n + 1) + 3 * (n - 299) * x^n - 900*x + 897)/(x - 1)^2
\\
\\ Where, for `n=5000`, we have:
\\      s(5000) = (-14100 * x^5001 + 14103 * x^5000 - 900*x + 897)/(x - 1)^2
\\
\\ Problem asks solving for `x`, such that `s(5000) = -600000000000`.
\\

print(solve(x=-1,2,(-14100 * x^5001 + 14103 * x^5000 - 900*x + 897)/(x - 1)^2 + 600000000000));
