#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# https://github.com/trizen

# https://projecteuler.net/problem=659

# Runtime: 59.361s

use 5.014;
use warnings;
use ntheory qw(factor addmod);

my $sum = 0;
my $mod = 1000000000000000000;

foreach my $n(1..10_000_000) {
    $sum = addmod($sum, (factor(4*$n*$n + 1))[-1], $mod);
}

say $sum;
