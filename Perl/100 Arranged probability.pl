#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 17 February 2017
# License: GPLv3
# https://github.com/trizen

# https://projecteuler.net/problem=100

# Runtime: 0.004s

use strict;
use warnings;

for (my $m = 1 ; ; ++$m) {

    my $n = 1/4 * (
        -(1 + sqrt(2)) * (3 - 2*sqrt(2))**$m
        -(1 - sqrt(2)) * (3 + 2*sqrt(2))**$m - 2
    );

    if ($n > 10**12) {

        my $b = 1/8 * (
            (sqrt(2) + 2) * (3 - 2*sqrt(2))**$m
          - (sqrt(2) - 2) * (3 + 2*sqrt(2))**$m + 4
        );

        printf("%.0f\n", $b);
        last;
    }
}
