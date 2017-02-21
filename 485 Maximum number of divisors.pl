#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 21 February 2017
# https://github.com/trizen

# https://projecteuler.net/problem=485

# Runtime: 1 min, 33 sec.

use 5.010;
use strict;
use integer;

use ntheory qw(:all);

my $r = 100_000;
my $n = 100_000_000;

my @divisors = map { scalar divisors($_) } 1 .. $r;
my $range_max = vecmax(@divisors);

my $sum = 0;

foreach my $i ($r + 1 .. $n + 1) {

    $sum += $range_max;

    my $d = divisors($i);
    if ($d > $range_max) {
        $range_max = $d;
    }

    push @divisors, $d;

    if (shift(@divisors) == $range_max) {
        $range_max = vecmax(@divisors);
    }
}

say $sum;
