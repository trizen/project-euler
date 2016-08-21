#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Website: https://github.com/trizen

# Find the last ten digits of the series, 1^1 + 2^2 + 3^3 + ... + 1000^1000.

# https://projecteuler.net/problem=48

use 5.010;
use strict;
use warnings;

use ntheory qw(powmod);

my $sum = 0;
my $mod = 10**10;

foreach my $i (1 .. 1000) {
    next if $i % 10 == 0;
    $sum += powmod($i, $i, $mod);
    $sum %= $mod;
}

say $sum;
