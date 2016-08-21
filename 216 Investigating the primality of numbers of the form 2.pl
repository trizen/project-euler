#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# Date: 18 August 2016
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=216

use 5.010;
use strict;
use integer;
use ntheory qw(is_prime);

my $p = 1;
my $count = 0;

for my $n (1 .. 50_000_000) {
    ++$count if is_prime($p += 4*$n+2);
}

say $count;
