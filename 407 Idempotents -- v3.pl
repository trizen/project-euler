#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 30 August 2019
# https://github.com/trizen

# https://projecteuler.net/problem=407

# Runtime: ~1 minute

# See also:
#   https://oeis.org/A182665 -- Greatest x < n such that n divides x*(x-1).

# M(n) = 1 iff n is a prime power p^k with k >= 1.

# a^2 == a (mod n) iff
#
#   a == 0 (mod x) and
#   a == 1 (mod y)
#
# where n = x*y and gcd(x,y) = 1.

# From this, we see that:
#   a = x * invmod(x, y)

use 5.010;
use strict;
use integer;

use ntheory qw(:all);

my $limit = 10**7;
my $sum   = prime_count($limit);

forcomposites {
    if (is_prime_power($_)) {
        ++$sum;
    }
    else {
        my $max = 0;

        foreach my $d (divisors($_)) {
            my $f = $_/$d;
            my $g = $d * invmod($d, $f);
            $max = $g if ($g > $max);
        }

        $sum += $max;
    }
} $limit;

say $sum;
