#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 18 October 2017
# https://github.com/trizen

# https://projecteuler.net/problem=183

# Runtime: 0.031s

use 5.010;
use strict;
use warnings;

use ntheory qw(gcd valuation);

my $sum = 0;

foreach my $n (5 .. 10000) {
    my $M = sprintf('%.0f', $n / exp(1));
    my $r = $M / gcd($n, $M);

    $r /= 2**valuation($r, 2) if ($r % 2 == 0);
    $r /= 5**valuation($r, 5) if ($r % 5 == 0);

    ($r == 1) ? ($sum -= $n) : ($sum += $n);
}

say $sum;
