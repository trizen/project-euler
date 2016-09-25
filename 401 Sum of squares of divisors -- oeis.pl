#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# Date: 25 September 2016
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=401

use 5.010;
use strict;

use LWP::Simple qw(get);
use Math::BigNum qw(:constant);

foreach my $line (split(/\R/, get('https://oeis.org/A188138/b188138.txt'))) {
    my ($i, $n) = split(' ', $line);

    if ($i == 15) {
        say $n % 10**9;
        last;
    }
}
