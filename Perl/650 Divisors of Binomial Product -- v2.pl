#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 15 January 2019
# https://github.com/trizen

# Formula for computing the sum of divisors of the product of binomials.

# Using the identities:
#   Product_{k=0..n} binomial(n, k) = Product_{k=1..n} k^(2*k - n - 1)
#                                   = hyperfactorial(n)/superfactorial(n)

# and the fact that the sigma function is multiplicative with:
#   sigma_m(p^k) = (p^(m*(k+1)) - 1)/(p^m - 1)

# See also:
#   https://oeis.org/A001142
#   https://oeis.org/A323444

# Paper:
#   Jeffrey C. Lagarias, Harsh Mehta
#   Products of binomial coefficients and unreduced Farey fractions
#   http://arxiv.org/abs/1409.4145

# https://projecteuler.net/problem=650

# Runtime: 29.965s

use 5.020;
use strict;
use warnings;

no warnings 'recursion';

use experimental qw(signatures);
use ntheory qw(powmod invmod mulmod forprimes todigits vecsum);

sub p650 ($n, $m) {

    my @D = (1);

    forprimes {

        my $p      = $_;
        my $fp_acc = 0;
        my $p_inv  = invmod($p - 1, $m);

        foreach my $k ($p .. $n) {
            my $fp = ($k - vecsum(todigits($k, $p))) / ($p - 1);
            my $e = $fp * ($k - 1) - 2 * $fp_acc;

            $D[$k - 1] = mulmod($D[$k - 1] // 1, mulmod(powmod($p, $e + 1, $m) - 1, $p_inv, $m), $m);
            $fp_acc += $fp;
        }
    } $n;

    my $sum = 0;
    foreach my $d (@D) {
        $sum += $d;
        $sum %= $m;
    }

    return $sum;
}

say p650(20_000, 1000000007);
