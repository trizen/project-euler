#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 13 January 2017
# License: GPLv3
# https://github.com/trizen

# https://projecteuler.net/problem=182

# Runtime: 1.200s

use 5.010;
use strict;
use warnings;

use ntheory qw(gcd);

my $p = 1009;
my $q = 3643;

my $n   = ($p * $q);
my $phi = ($p - 1) * ($q - 1);
my $sum = 0;

foreach my $e (2 .. $phi - 1) {
    if (gcd($e, $phi) == 1) {
        if (    gcd($e - 1, $p - 1) == 2
            and gcd($e - 1, $q - 1) == 2) {
            $sum += $e;
        }
    }
}

say $sum;
