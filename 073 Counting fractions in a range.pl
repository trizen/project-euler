#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# Date: 15 August 2016
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=73

# Runtime: 2.695s

use 5.010;
use strict;

use ntheory qw(gcd);

sub count_frac {
    my ($n, $min, $max) = @_;

    my $count = 0;

    foreach my $n ($min + $max .. $n) {
        foreach my $k (int($n / $min) + 1 .. int(($n - 1) / $max)) {
            ++$count if (gcd($n, $k) == 1);
        }
    }

    $count;
}

say count_frac(12_000, 3, 2);
