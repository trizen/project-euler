#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 13 January 2017
# License: GPLv3
# https://github.com/trizen

# https://projecteuler.net/problem=182

# Runtime: 2.711s

use 5.010;
use strict;
use warnings;

use ntheory qw(gcd powmod);

my $p = 1009;
my $q = 3643;

my $n   = ($p * $q);
my $phi = ($p - 1) * ($q - 1);
my $sum = 0;

foreach my $e (2 .. $phi - 1) {
    if (gcd($e, $phi) == 1) {
        if (   powmod($q - 1, $e, $n) == $q - 1
            or powmod($p - 1, $e, $n) == $p - 1
            or powmod(73282,  $e, $n) == 73282
            or powmod(462662, $e, $n) == 462662
            or powmod(3028,   $e, $n) == 3028) {
            next;
        }
        $sum += $e;
    }
}

say $sum;
