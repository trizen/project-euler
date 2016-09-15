#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Website: https://github.com/trizen

# An irrational decimal fraction is created by concatenating the positive integers:
# 0.123456789101112131415161718192021...

# It can be seen that the 12th digit of the fractional part is 1.

# If dn represents the nth digit of the fractional part, find the value of the following expression.
# d1 × d10 × d100 × d1000 × d10000 × d100000 × d1000000

# https://projecteuler.net/problem=40

# Runtime: 0.031s

use 5.010;
use strict;
use integer;

my $str = '';

for (my $i = 1 ; ; ++$i) {
    $str .= $i;
    last if (length($str) >= 1000000);
}

my $prod = 1;

foreach my $i (0 .. 6) {
    $prod *= substr($str, 10**($i) - 1, 1);
}

say $prod;
