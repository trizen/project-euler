#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Website: https://github.com/trizen

# How many different ways can one hundred be written as a sum of at least two positive integers?

# https://projecteuler.net/problem=76

# Runtime: 0.071s

use 5.010;
use strict;

use Memoize qw(memoize);

memoize('count');

my @nums;

sub count {
    my ($n, $i, $sum) = @_;

    $i   //= 0;
    $sum //= 0;

    return 1 if ($sum == $n);
    return 0 if ($sum > $n);
    return 0 if ($i > $#nums);

    count($n, $i + 1, $sum) +
    count($n, $i, $sum + $nums[$i]);
}

my $n = 100;
@nums = 1 .. $n - 1;
say count(100);
