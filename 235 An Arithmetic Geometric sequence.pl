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

#use Math::AnyNum qw(:overload);

my $n = 5000;
my $u = -600000000000;

my $r1 = 1;
my $r2 = 2;

while ($r1 <= $r2) {

    my $r = ($r1 + $r2) / 2;
    my $v = ((3*($n-299) * $r**$n) - (3*($n-300) * $r**($n+1)) - 900*$r + 897)/($r-1)**2 - $u;

    if (abs($r1 - $r2) < 1e-14) {
        printf("%.12f\n", $r1);
        last;
    }

    if ($v > 0) {
        $r1 = $r;
    }
    else {
        $r2 = $r;
    }
}
