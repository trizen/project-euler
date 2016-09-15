#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# Date: 15 August 2016
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=73

# Runtime: 26.004s

use 5.010;
use strict;

use ntheory qw(gcd forcomb);

sub count_frac {
    my ($n, $min, $max) = @_;

    my $count = 0;

    forcomb {
        my ($x, $y) = ($_[0] + 1, $_[1] + 1);
        if ($x / $y > $min and $x / $y < $max and gcd($x, $y) == 1) {
            ++$count;
        }
    } $n, 2;

    $count;
}

say count_frac(12_000, 1 / 3, 1 / 2);
