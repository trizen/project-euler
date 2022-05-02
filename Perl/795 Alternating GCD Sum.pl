#!/usr/bin/perl

# Author: Trizen
# Date: 02 May 2022
# https://github.com/trizen

# Alternating GCD Sum
# https://projecteuler.net/problem=795

# Formula:
#   g(4) = 6
#   g(n) = -n, if n is odd
#   g(2^k * n) = (g2(2^k) - 2^k) * Prod_{p^e | n} g2(p^e), where n is odd

# where:
#   g2(n) = A078430(n)
#         = Sum_{d|n} d * phi(n/d) * f(n/d)

# where:
#   f(n) = A000188(n)
#        = Prod_{p^e | n} p^floor(e/2)

# Then:
#   G(n) = Sum_{k=1..n} g(k)

# See also:
#   https://oeis.org/A078430 -- Sum of gcd(k^2,n) for 1 <= k <= n.
#   https://oeis.org/A199084 -- Sum_{k=1..n} (-1)^(k+1) gcd(k,n).
#   https://oeis.org/A000188 -- Number of solutions to x^2 == 0 (mod n).

# Runtime: ~22 seconds.

use 5.020;
use strict;
use warnings;

use ntheory qw(:all);
use experimental qw(signatures);

sub f ($n) {    # OEIS: A000188
    vecprod(map { ($_->[1] == 1) ? 1 : powint($_->[0], $_->[1] >> 1) } factor_exp($n));
}

my %cache;

sub g2 ($n) {    # OEIS: A078430

    if (is_prime($n)) {
        return ($n + ($n - 1));
    }

    if (exists $cache{$n}) {
        return $cache{$n};
    }

    my $sum = 0;

    foreach my $d (divisors($n)) {
        my $nod = divint($n, $d);
        $sum = addint($sum, vecprod($d, euler_phi($nod), f($nod)));
    }

    $cache{$n} = $sum;
}

sub g ($n) {

    return 6 if $n == 4;

    if ($n % 2 == 1) {    # n is odd
        return -$n;
    }

    if (is_prime($n >> 1)) {
        return $n - 1;
    }

    my $v = valuation($n, 2);
    my $t = $n >> $v;
    my $w = g2(1 << $v) - (1 << $v);

    return $w if ($t == 1);
    return mulint($w, vecprod(map { g2(powint($_->[0], $_->[1])) } factor_exp($t)));
}

sub G ($n) {
    my $sum = 0;
    foreach my $k (1 .. $n) {
        $sum += g($k);
    }
    return $sum;
}

use Test::More tests => 7;

is(g(2 * 47), 93);
is(g(97),     -97);
is(g(3 * 31), -93);

is(G(100),  7111);
is(G(200),  36268);
is(G(300),  89075);
is(G(1234), 2194708);

say G(12345678);
