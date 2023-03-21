#!/usr/bin/perl

# Author: Trizen
# Edit: 21 March 2023
# https://github.com/trizen

# https://projecteuler.net/problem=87

# Runtime: 1.097s

use 5.010;
use strict;

use ntheory qw(:all);

my @seen;
my $count = 0;
my $limit = 50e6;

foreach my $p (@{primes(rootint($limit, 2))}) {
    foreach my $q (@{primes(rootint($limit - $p**2, 3))}) {
        foreach my $r (@{primes(rootint($limit - $p**2 - $q**3, 4))}) {
            ++$count if !$seen[$p**2 + $q**3 + $r**4]++;
        }
    }
}

say $count;
