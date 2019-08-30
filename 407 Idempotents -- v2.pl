#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 25 August 2016
# https://github.com/trizen

# https://projecteuler.net/problem=407

# Runtime: ~2 minutes

use 5.010;
use strict;
use integer;

use ntheory qw(:all);
use List::Util qw(uniq product);

my $limit = 10**7;
my $sum   = prime_count($limit);

forcomposites {
    if (is_prime_power($_)) {
        ++$sum;
    }
    else {
        my $max = 0;
        my $rad = product(uniq(factor($_)));

        foreach my $d (divisors($rad)) {
            my $f = $_ / $d;
            my $g = $d * powmod($d, euler_phi($f) - 1, $f);
            $max = $g if ($g > $max);
        }

        $sum += $max;
    }
} $limit;

say $sum;
