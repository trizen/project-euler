#!/usr/bin/perl

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

use 5.020;
use strict;
use warnings;

no warnings 'recursion';

use experimental qw(signatures);
use ntheory qw(powmod invmod mulmod forprimes todigits vecsum);

my @cache;

sub sum_of_digits ($n, $p) {
    return 0 if ($n <= 0);
    $cache[$n][$p] //= vecsum(todigits($n - 1, $p)) + sum_of_digits($n - 1, $p);
}

sub product_of_binomial_power ($n, $p) {
    (2 * sum_of_digits($n, $p) - ($n - 1) * vecsum(todigits($n, $p))) / ($p - 1);
}

sub sigma_of_binomial_product ($n, $m = 1) {
    my $prod = 1;

    forprimes {

        my $p = $_;
        my $k = product_of_binomial_power($n, $p);

        $prod = mulmod($prod, mulmod(powmod($p, $k + 1, $m) - 1, invmod($p - 1, $m), $m), $m);
    } $n;

    $prod;
}

my $n   = 20_000;
my $sum = 0;
my $mod = 1000000007;

foreach my $k (1 .. $n) {
    say "k = $k";
    $sum += sigma_of_binomial_product($k, $mod);
    $sum %= $mod;
}

say $sum;
