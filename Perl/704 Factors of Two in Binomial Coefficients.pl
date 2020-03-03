#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 03 March 2020
# https://github.com/trizen

# Factors of Two in Binomial Coefficients
# https://projecteuler.net/problem=704

# Runtime: 0.031s

# The maximal value of m for a given n-1, is given by:
#   A053645(n) = n - 2^floor(log_2(n))

# The valuation of 2 in binomial(n-1,m), for the value of m defined above, is given by:
#   A119387(n) = floor(log_2(n)) - valuation(n,2)

# Then the value of F(n) is given by:
#   F(n) = A119387(n+1)

# To find S(n) = Sum_{k=1..n} F(k), we first define:
#   A(n) = A061168(n) = Sum_{k=1..n} floor(log_2(k))
#   B(n) = A011371(n) = Sum_{k=1..n} valuation(k,2)

# Then we have:
#   S(n) = A(n+1) - B(n+1)

# For computing A(n) and B(n) efficiently, we have the following formulas:
#   A(n) = (n+1)*floor(log_2(n)) - 2*(2^floor(log_2(n)) - 1)
#   B(n) = n - hammingweight(n)

# See also:
#   https://oeis.org/A053645
#   https://oeis.org/A119387
#   https://oeis.org/A061168
#   https://oeis.org/A011371

use 5.020;
use warnings;

use ntheory qw(:all);
use experimental qw(signatures);

sub A($n) {
    ($n+1)*logint($n,2) - 2*(powint(2, logint($n, 2)) - 1);
}

sub B($n) {
    $n - hammingweight($n);
}

sub S($n) {
    A($n+1) - B($n+1);
}

say S(powint(10, 16));

__END__
S(10^(10^5)) = 3321898588...7585514573 (100006 digits)
S(10^(10^6)) = 3321925127...5321046359 (1000007 digits)
S(10^(10^7)) = 3321927796...6616569057 (10000008 digits)
S(10^(10^8)) = 3321928065...3266366113 (100000009 digits)
