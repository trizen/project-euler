#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Website: https://github.com/trizen

# General formula: n^9 + n^6 * p = (n^3 + n^2)^3 where p is a prime number.
# From the above formula results that p must have the form: 3n^2 + 3n + 1.

# https://projecteuler.net/problem=131

# Runtime: 0.040s

use strict;
use integer;
use ntheory qw(is_prime);

my $count = 0;

for(my $n = 1; ; $n++) {
    my $p = 3*$n**2 + 3*$n + 1;
    last if $p >= 1e6;
    ++$count if is_prime($p);
}

print "$count\n";
