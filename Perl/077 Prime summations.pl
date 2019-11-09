#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=77

# Runtime: 0.245s

use 5.010;
use strict;
use warnings;
use ntheory qw(primes);
use Memoize qw(memoize);

my $primes;

sub count {
    my ($n, $i, $sum) = @_;

    ($sum == $n)                      ? 1
    : ($sum > $n || $i > $#{$primes}) ? 0
    : (count($n, $i, $sum + $primes->[$i]) +
       count($n, $i+1, $sum))
}

memoize('count');

foreach my $i (4 .. 1e6) {
    $primes = primes(1, $i - 2);
    if (count($i, 0, 0) > 5000) {
        say $i; last;
    }
}
