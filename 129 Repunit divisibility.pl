#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 11 May 2017
# https://github.com/trizen

# https://projecteuler.net/problem=129

# Runtime: 1.116s

use 5.010;
use strict;
use warnings;

use ntheory qw(powmod gcd);

for (my $n = 1e6 ; ; ++$n) {

    gcd($n, 10) == 1 or next;

    my $k = 1;
    for (my $sum = 1 ; ; ++$k) {
        $sum += powmod(10, $k, $n);
        $sum %= $n;
        last if $sum == 0;
    }

    if ($k + 1 > 1e6) {
        say "A($n) = ", $k + 1;
        last;
    }
}
