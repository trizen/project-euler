#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# Date: 17 August 2016
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=94

use 5.010;
use strict;
use warnings;

my $n     = 1;
my $sum   = 0;
my $limit = 1_000_000_000;

while (1) {
    my $x = (((7 - 4 * sqrt(3))**$n)
            + (7 + 4 * sqrt(3))**$n + 1) / 3;

    my $y = ((sqrt(3) + 2) * (7 - 4 * sqrt(3))**($n + 1)
           - (sqrt(3) - 2) * (7 + 4 * sqrt(3))**($n + 1) - 1) / 3;

    my $p1 = 3 * $x + 1;
    my $p2 = 3 * $y - 1;

    last if ($p1 > $limit and $p2 > $limit);

    $sum += $p1 if $p1 <= $limit;
    $sum += $p2 if $p2 <= $limit;

    ++$n;
}

say $sum;
