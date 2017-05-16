#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 16 May 2017
# https://github.com/trizen

# https://projecteuler.net/problem=173

# Runtime: 0.298s

use 5.010;
use strict;
use warnings;

my $count = 0;
my $tiles = 1e6;

foreach my $k (1 .. $tiles >> 2) {
    for (my ($sum, $j) = (0, $k + 2) ; ; $j += 2) {
        $sum += 2 * $j + 2 * ($j - 2);
        $sum <= $tiles ? ++$count : last;
    }
}

say $count;
