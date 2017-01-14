#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# Date: 25 August 2016
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=407

# Runtime: 2 min 32.26s

use 5.010;
use strict;
use integer;

use ntheory qw(
  powmod
  vecprod
  forcomb
  euler_phi
  factor_exp
  prime_count
  is_prime_power
  forcomposites
);

my $limit = 10**7;
my $sum   = prime_count($limit);

forcomposites {
    if (is_prime_power($_)) {
        ++$sum;
    }
    else {
        my $c   = $_;
        my $max = 0;

        my @f   = map { $_->[0] } factor_exp($c);
        my $len = scalar(@f);

        foreach my $i (1 .. $len - 1) {
            forcomb {
                my $d = vecprod(@f[@_]);
                my $f = $c / $d;
                my $g = $d * powmod($d, euler_phi($f) - 1, $f);
                $g > $max && ($max = $g);
            } $len, $i;
        }

        $sum += $max;
    }
} $limit;

say $sum;
