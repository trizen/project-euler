#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=78

# Runtime: 8.085s

use 5.010;
use strict;
use warnings;

my $n = 1;
my @p = (1);

while (1) {
    my $i = 0;
    my $q = 1;
    push @p, 0;

    while ($q <= $n) {
        $p[$n] += ($i % 4 > 1 ? -1 : 1) * $p[$n - $q];
        $p[$n] %= 1000000;
        my $j = int(++$i / 2) + 1;
        if ($i % 2 != 0) {
            $j *= -1;
        }
        $q = int($j * (3 * $j - 1) / 2);
    }

    last if ($p[$n] == 0);
    ++$n;
}

say $n;
