#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 09 October 2016
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=531

# Runtime: 20.443s

use 5.010;
use strict;
use integer;

use ntheory qw(euler_phi chinese);

my $sum = 0;

foreach my $m (1_000_000 .. 1_005_000 - 1) {
    foreach my $n (1_000_000 .. $m - 1) {
        $sum += chinese([euler_phi($n), $n], [euler_phi($m), $m]);
    }
}

say $sum;
