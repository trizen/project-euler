#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 27 January 2017
# https://github.com/trizen

# https://projecteuler.net/problem=41

# Runtime: 0.134s

use 5.010;
use strict;
use ntheory qw(forperm is_prime);

foreach my $n (reverse(1 .. 8)) {
    my $found = 0;
    my $prime = 0;

    forperm {
        my $k = join('', map { $_ + 1 } @_);
        if (is_prime($k)) {
            $found = 1;
            $prime = $k;
        }
    } $n;

    if ($found) {
        say "$n-digit pandigital prime: $prime";
        last;
    }
}
