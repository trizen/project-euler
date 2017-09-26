#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 27 September 2017
# https://github.com/trizen

# https://projecteuler.net/problem=235

# Runtime: 0.009s

use 5.010;
use strict;
use warnings;

my $x1 = 1;
my $x2 = 2;

while ($x1 <= $x2) {

    my $x = ($x1 + $x2) / 2;
    my $r = (-14100 * $x**5001 + 14103 * $x**5000 - 900 * $x + 897) / ($x - 1)**2 + 600000000000;

    if (abs($x1 - $x2) < 1e-14) {
        printf("%.12f\n", $x1);
        last;
    }

    if ($r > 0) {
        $x1 = $x;
    }
    else {
        $x2 = $x;
    }
}
