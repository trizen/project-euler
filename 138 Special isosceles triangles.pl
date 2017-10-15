#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 15 October 2017
# https://github.com/trizen

# Runtime: 0.008s

# https://projecteuler.net/problem=138

use 5.010;
use strict;
use warnings;

my $n    = 1;
my $diff = 1;
my $prev = 1;

my $sum = 0;

foreach my $k (1 .. 12) {
    $n = $prev * (17 + 1) - $diff;
    $sum += $n;
    $diff = $prev;
    $prev = $n;
    say "L($k) = $n";
}

say "\nSum: ", $sum;
