#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 17 August 2017
# https://github.com/trizen

# https://projecteuler.net/problem=429

# Runtime: 5.372s

use 5.020;
use strict;
use warnings;

use experimental qw(signatures);
use ntheory qw(forprimes mulmod powmod vecsum todigits);

sub factorial_power ($n, $p) {
    ($n - vecsum(todigits($n, $p))) / ($p - 1);
}

sub sigma_of_unitary_divisors_of_factorial ($n, $k, $m) {

    my $sigma = 1;

    forprimes {
        $sigma = mulmod($sigma, 1 + powmod($_, $k * factorial_power($n, $_), $m), $m);
    } $n;

    return $sigma;
}

my $n = 100_000_000;
my $m = 1_000_000_009;

say sigma_of_unitary_divisors_of_factorial($n, 2, $m);
