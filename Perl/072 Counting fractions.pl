#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# Date: 15 August 2016
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=72

# Runtime: 0.378s

use 5.010;
use strict;
use warnings;

use ntheory qw(euler_phi);

sub count_frac {
    my ($n) = @_;

    my $sum = 0;
    foreach my $k (1 .. $n) {
        $sum += euler_phi($k);
    }
    $sum - 1;
}

say count_frac(1e6);
