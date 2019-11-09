#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# Date: 28 August 2016
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=102

use 5.010;
use strict;
use warnings;

my $count = 0;

while (<>) {
    my ($ax, $ay, $bx, $by, $cx, $cy) = split(/,/);

    my $p = $ax * $by - $ay * $bx;
    my $q = $bx * $cy - $by * $cx;
    my $r = $cx * $ay - $cy * $ax;

    if (   ($p > 0 and $q > 0 and $r > 0)
        or ($p < 0 and $q < 0 and $r < 0)) {
        ++$count;
    }
}

say $count;
