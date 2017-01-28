#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 28 January 2017
# https://github.com/trizen

# https://projecteuler.net/problem=44

# Runtime: 1.210s

use 5.010;
use strict;
use integer;

use ntheory qw(is_power sqrtint);

sub is_pentagonal {
    my ($n) = @_;
    is_power(24*$n + 1, 2)
      && sqrtint(24*$n + 1) % 6 == 5 ? 1 : 0;
}

OUTER: for (my $n = 1 ; ; ++$n) {
    my $p1 = $n * (3*$n - 1) >> 1;
    foreach my $m (1 .. $n) {
        my $p2 = $m * (3*$m - 1) >> 1;
        if (    is_pentagonal($p1 + $p2)
            and is_pentagonal(abs($p1 - $p2))) {
            say abs($p1 - $p2);
            last OUTER;
        }
    }
}
