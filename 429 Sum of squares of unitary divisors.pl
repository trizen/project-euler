#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 17 August 2017
# https://github.com/trizen

# https://projecteuler.net/problem=429

# Runtime: 4.686s

# Answer: 98792821

use 5.010;
use strict;
use warnings;

use ntheory qw(forprimes mulmod powmod);

sub power {
    my ($n, $p) = @_;

    my $count = 0;

    while ($n >= $p) {
        $count += int($n /= $p);
    }

    return $count;
}

sub sigma_of_unitary_divisors_of_factorial {
    my ($n, $k, $m) = @_;

    my $sigma = 1;

    forprimes {
        $sigma = mulmod($sigma, 1 + powmod($_, $k * power($n, $_), $m), $m);
    } $n;

    return $sigma;
}

my $n = 100_000_000;
my $m = 1_000_000_009;

say sigma_of_unitary_divisors_of_factorial($n, 2, $m);
