#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 28 January 2017
# https://github.com/trizen

# https://projecteuler.net/problem=47

# Runtime: 0.061s

use 5.010;
use strict;
use integer;

use ntheory qw(factor_exp);

for (my $n = 647 ; ; ++$n) {
    if (    factor_exp($n + 0) == 4
        and factor_exp($n + 1) == 4
        and factor_exp($n + 2) == 4
        and factor_exp($n + 3) == 4) {
        say $n;
        last;
    }
}
