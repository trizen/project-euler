#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# Date: 18 August 2016
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=75

use 5.010;
use strict;
use integer;
use ntheory qw(gcd);

my $limit = 1_500_000;
my $end   = sqrt($limit);

my %triangle;
foreach my $n (1 .. $end - 1) {
    for (my $m = $n + 1 ; $m <= $end ; $m += 2) {

        if (gcd($n, $m) == 1) {    # m and n coprime

            my $k = 1;
            while (1) {

                my $x = $k * ($m**2 - $n**2);
                my $y = $k * (2 * $m * $n);
                my $z = $k * ($m**2 + $n**2);

                last if $x + $y + $z > $limit;

                ++$triangle{$x + $y + $z};
                ++$k;
            }
        }
    }
}

my $count = 0;
foreach my $v(values %triangle) {
    ++$count if $v == 1;
}

say $count;
