#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 13 March 2018
# https://github.com/trizen

# https://projecteuler.net/problem=622

# Runtime: 0.046s

use 5.020;
use strict;
use warnings;

use experimental qw(signatures);
use ntheory qw(znorder lcm vecprod forcomb);

sub rshuffle_cycle_len ($n) {
    lcm(2, znorder(2, $n - 1));
}

# The prime factorization of 2^60-1
my @primes = (3, 3, 5, 5, 7, 11, 13, 31, 41, 61, 151, 331, 1321);

my %seen;
my $sum = 0;

foreach my $k (1 .. @primes) {
    forcomb {
        my $prod = vecprod(@primes[@_]);

        if (rshuffle_cycle_len($prod + 1) == 60) {
            $sum += $prod + 1 if !$seen{$prod}++;
        }

    } scalar(@primes), $k;
}

say $sum;
