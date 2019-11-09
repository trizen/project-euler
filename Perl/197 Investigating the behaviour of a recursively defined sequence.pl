#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 15 April 2017
# License: GPLv3
# https://github.com/trizen

# https://projecteuler.net/problem=197

# Runtime: 15 ms

use 5.010;
use strict;
use Memoize;

Memoize::memoize('a');

sub a {
    my ($n) = @_;
    $n == 0 ? -1 : int(2**(30.403243784 - (a($n - 1))**2)) * 1e-9;
}

for (my $n = 1 ; ; ++$n) {
    if (a($n) == a($n + 2) and a($n + 1) == a($n + 3)) {
        say a($n) + a($n + 1);
        last;
    }
}
