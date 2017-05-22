#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 20 May 2017
# https://github.com/trizen

# https://projecteuler.net/problem=174

# 209566

# Runtime: 1.050s

use 5.010;
use strict;
use warnings;

my %counts;
my $tiles = 1000000;

foreach my $k (1 .. $tiles >> 2) {
    for (my ($sum, $j) = (0, $k + 2) ; ; $j += 2) {
        $sum += 2 * $j + 2 * ($j - 2);
        $sum <= $tiles ? ++$counts{$sum} : last;
    }
}

my $count = 0;
foreach my $value (values %counts) {
    if ($value >= 1 and $value <= 10) {
        ++$count;
    }
}
say $count;
