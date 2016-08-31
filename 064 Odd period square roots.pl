#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 21 August 2016
# License: GPLv3
# https://github.com/trizen

# https://projecteuler.net/problem=64

# Algorithm from:
#   http://web.math.princeton.edu/mathlab/jr02fall/Periodicity/mariusjp.pdf

use 5.010;
use strict;

use ntheory qw(is_power sqrtint);

sub period_length {
    my ($n) = @_;

    my $x_0 = sqrtint($n);
    my $y   = $x_0;
    my $z   = $n - $x_0 * $x_0;

    my $y_0 = $y;
    my $z_0 = $z;

    my $period = 0;

    do {
        $y = int(($x_0 + $y) / $z) * $z - $y;
        $z = int(($n - $y * $y) / $z);
        ++$period;
    } until (($y == $y_0) && ($z == $z_0));

    $period;
}

my $count = 0;
for my $i (1 .. 10000) {
    if (!is_power($i, 2)) {
        ++$count if period_length($i) % 2 != 0;
    }
}

say $count;
