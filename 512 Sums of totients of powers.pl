#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 28 September 2016
# Website: https://github.com/trizen

# https://projecteuler.net/problem=512

# Runtime: 5 min 02.77s

use 5.010;
use strict;
use integer;
use ntheory qw(euler_phi);

sub g {
    my ($n) = @_;

    my $sum = 0;
    for (my $k = 1 ; $k <= $n ; $k += 2) {
        $sum += euler_phi($k);
    }
    $sum;
}

say g(5 * 10**8);
