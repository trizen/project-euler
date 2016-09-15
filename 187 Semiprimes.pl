#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Website: https://github.com/trizen

# How many composite integers, n < 10^8, have precisely two, not necessarily distinct, prime factors?

# https://projecteuler.net/problem=187

# Runtime: 2.402s

use 5.010;
use strict;
use warnings;

use ntheory qw(primes);

my $limit = 10**8;
my $primes = primes(0, $limit / 2);

my $count = 0;
my $end   = $#{$primes};

foreach my $i (0 .. $end) {
    foreach my $j ($i .. $end) {
        $primes->[$i] * $primes->[$j] >= $limit ? last : ++$count;
    }
}

say $count;
