#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 28 January 2017
# https://github.com/trizen

# https://projecteuler.net/problem=69

# Runtime: 0.039s

use 5.010;
use strict;
use integer;

use ntheory qw(prime_iterator);

my $limit = 1_000_000;
my $iter  = prime_iterator();

my $primorial = 1;

for (my $p = $iter->() ; ; $p = $iter->()) {
    $primorial *= $p;
    if ($primorial > $limit) {
        $primorial /= $p;
        last;
    }
}

say $primorial;
