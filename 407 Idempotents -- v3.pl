#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# Date: 25 August 2016
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=407

# Runtime: 2 min 17.86s

use 5.010;
use strict;
use integer;

use ntheory qw(
  powmod
  factor
  euler_phi
  fordivisors
  prime_count
  is_prime_power
  forcomposites
  );

use List::Util qw(uniq product);

my $limit = 10**7;
my $sum   = prime_count($limit);

forcomposites {
    if (is_prime_power($_)) {
        ++$sum;
    }
    else {
        my $c   = $_;
        my $max = 0;

        my $p = product(uniq(factor($c)));

        fordivisors {
            my $d = $p / $_;
            my $f = $c / $d;
            my $g = $d * powmod($d, euler_phi($f) - 1, $f);
            $g > $max && ($max = $g);
        } $p;

        $sum += $max;
    }
} $limit;

say $sum;
