#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 09 February 2017
# https://github.com/trizen

# https://projecteuler.net/problem=193

# Runtime: 4.397s

use 5.010;
use strict;
use integer;

use ntheory qw(moebius);

sub squarefree_count_pow2 {
    my ($pow) = @_;

    my $count = 0;
    my $n     = 1 << $pow;

    my $k = 1;
    foreach my $m (moebius(1, 1 << ($pow >> 1))) {
        $count += $m * $n / ($k++)**2;
    }

    return $count;
}

say squarefree_count_pow2(50);
