#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# Date: 14 August 2016
# License: GPLv3
# Website: https://github.com/trizen

# Find the number of integers 1 < n < 107, for which n and n + 1 have the same number of positive divisors.

# https://projecteuler.net/problem=179

use 5.010;
use ntheory qw(divisors);

my $count = 0;
my $prev  = 1;

for my $n (2 .. 10**7 - 1) {
    my $dc = divisors($n);
    ++$count if $dc == $prev;
    $prev = $dc;
}

say $count;
