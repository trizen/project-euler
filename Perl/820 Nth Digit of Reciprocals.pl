#!/usr/bin/perl

# N-th Digit of Reciprocals
# https://projecteuler.net/problem=820

# Runtime: 10.467s

use 5.036;
use ntheory qw(:all);

sub nth_digit_of_fraction($n, $x, $y, $base = 10) {
    divint($base * powmod($base, $n - 1, $y) * $x, $y) % $base;
}

my $sum = 0;
my $n   = 1e7;

foreach my $k (1 .. $n) {
    $sum += nth_digit_of_fraction($n, 1, $k);
}

say $sum;
