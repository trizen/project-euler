#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 21 February 2018
# https://github.com/trizen

# https://projecteuler.net/problem=479

# Runtime: 1.225s

use 5.010;
use strict;
use warnings;

use ntheory qw(powmod divmod mulmod);

my $sum = 0;

my $n = 10**6;
my $m = 1000000007;

foreach my $k (1 .. $n) {
    my $p = mulmod($k, $k, $m) - 1;
    $sum += divmod($p * ((-1)**$n * powmod($p, $n, $m) - 1), $p + 1, $m);
    $sum %= $m;
}

say $sum;
