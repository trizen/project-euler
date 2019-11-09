#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# Date: 25 August 2016
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=407

# Runtime: 1 min 16.11s

use 5.010;
use strict;
use integer;

use ntheory qw(
  invmod
  fordivisors
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

        fordivisors {
            my $g = invmod($_, $c / $_) * $_;
            $g > $max && ($max = $g);
        } $c;

        $sum += $max;
    }
} $limit;

say $sum;
