#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 16 May 2017
# https://github.com/trizen

# https://projecteuler.net/problem=173

# 1572729

# Runtime: 0.363s

use 5.010;
use strict;
use warnings;

my $count = 0;
my $tiles = 1e6;

for (my $k = 1 ; $k <= $tiles >> 2 ; ++$k) {
    for (my ($sum, $j) = (0, $k + 2) ; ; $j += 2) {
        $sum += 2 * $j + 2 * ($j - 2);
        $sum <= $tiles ? ++$count : last;
    }
}

say $count;
