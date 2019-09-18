#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 28 August 2016
# License: GPLv3
# https://github.com/trizen

# https://projecteuler.net/problem=211

# Runtime: 45.717s

use 5.010;
use strict;

use ntheory qw(divisor_sum is_square forcomposites);

my $sum   = 1;
my $limit = 64_000_000;

forcomposites {
    if (is_square(divisor_sum($_, 2))) {
        $sum += $_;
    }
} 1, $limit-1;

say $sum;
