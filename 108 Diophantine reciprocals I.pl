#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 17 February 2017
# License: GPLv3
# https://github.com/trizen

# https://projecteuler.net/problem=108

# Runtime: 7.114s

use 5.010;
use strict;
use integer;

use ntheory qw(divisors);

for (my $n = 1 ; ; ++$n) {
    if ((divisors($n * $n) + 1) >> 1 > 1000) {
        say $n;
        last;
    }
}
