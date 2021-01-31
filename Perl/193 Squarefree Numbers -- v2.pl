#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 09 February 2017
# https://github.com/trizen

# https://projecteuler.net/problem=193

# Runtime: 3.838s

use 5.010;
use strict;
use integer;

use ntheory qw(:all);

sub squarefree_count {
    my ($n) = @_;

    my $count = 0;

    my $k = 0;
    foreach my $m (moebius(1, sqrtint($n))) {
        ++$k;
        $count += $m * $n / ($k*$k) if $m;
    }

    return $count;
}

say squarefree_count(1 << 50);
