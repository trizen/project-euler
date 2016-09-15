#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 31 August 2016
# License: GPLv3
# https://github.com/trizen

# https://projecteuler.net/problem=64

# Algorithm from:
#   http://web.math.princeton.edu/mathlab/jr02fall/Periodicity/mariusjp.pdf

# Runtime: 0.170s

use 5.010;
use strict;

use ntheory qw(is_power sqrtint);

sub period_length {
    my ($n) = @_;

    my $x = sqrtint($n);
    my $y = $x;
    my $z = 1;

    my $period = 0;

    do {
        $y = int(($x + $y) / $z) * $z - $y;
        $z = int(($n - $y * $y) / $z);
        ++$period;
    } until (($y == $x) && ($z == 1));

    $period;
}

my $count = 0;
for my $i (1 .. 10000) {
    if (!is_power($i, 2)) {
        ++$count if period_length($i) % 2 != 0;
    }
}

say $count;
