#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 09 February 2017
# https://github.com/trizen

# https://projecteuler.net/problem=193

# Runtime: 16.807s

use 5.010;
use strict;
use integer;

use ntheory qw(moebius sqrtint);

sub squarefree_count {
    my ($n) = @_;

    my $count = 0;

    foreach my $k (1 .. sqrtint($n)) {
        $count += moebius($k) * $n / ($k * $k);
    }

    return $count;
}

say squarefree_count(1 << 50);
