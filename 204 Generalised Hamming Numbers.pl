#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 01 May 2017
# License: GPLv3
# https://github.com/trizen

# https://projecteuler.net/problem=204

# Runtime: 1.503s

use 5.010;
use strict;
use warnings;

use ntheory qw(primes);

my @h = (1);
foreach my $p (@{primes(100)}) {
    foreach my $n (@h) {
        if ($n * $p <= 1e9) {
            push @h, $n * $p;
        }
    }
}

say scalar(@h);
