#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 27 January 2017
# https://github.com/trizen

# https://projecteuler.net/problem=39

# Runtime: 0.056s

use 5.010;
use strict;

use ntheory qw(is_power sqrtint);

my %t;
my $limit = 1000;

foreach my $i (1 .. $limit/3) {
    foreach my $j ($i + 1 .. $limit/2) {
        my $c = $i**2 + $j**2;
        last if ($i + $j + sqrt($c) > $limit);

        if (is_power($c, 2)) {
            my $k = sqrtint($c);
            ++$t{$i + $j + $k};
        }
    }
}

say +(sort { $t{$b} <=> $t{$a} } keys %t)[0];
