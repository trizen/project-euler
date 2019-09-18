#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 18 September 2019
# https://github.com/trizen

# These are prime numbers of the form n^2 + (n+1)^2.
# See also: https://oeis.org/A027862

# Runtime: ~22 seconds.

# https://projecteuler.net/problem=291

use 5.010;
use strict;
use integer;
use warnings;

use ntheory qw(:all);

my $count = 0;

for (my $n = 1 ; ; ++$n) {
    my $p = $n * $n + ($n + 1) * ($n + 1);
    last if ($p > 5 * 1e15);
    is_prime($p) && ++$count;
}

say $count;
