#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# https://github.com/trizen

# https://projecteuler.net/problem=343

# Runtime: 17.571s

use 5.010;
use strict;
use warnings;

use ntheory qw(factor);

my $sum = 0;

foreach my $k (1 .. 2 * 1e6) {
    $sum += (factor($k * $k * $k + 1))[-1] - 1;
}

say $sum;
