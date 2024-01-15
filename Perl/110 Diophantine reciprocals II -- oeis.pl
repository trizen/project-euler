#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 17 February 2017
# Website: https://github.com/trizen

# https://projecteuler.net/problem=110

# Runtime: 1.807s

use 5.010;
use strict;

use LWP::Simple qw(get);
use Math::AnyNum qw(:overload);

use ntheory qw(divisors);

for my $line (split(/\R/, get('https://oeis.org/A002093/b002093.txt'))) {
    my $n = (split(' ', $line))[-1] >> 1;
    if ((divisors($n * $n) + 1) >> 1 > 4e6) {
        say $n;
        last;
    }
}
