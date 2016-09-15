#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# Date: 17 August 2016
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=123

# Runtime: 0.169s

use 5.010;
use strict;
use warnings;

use ntheory qw(nth_prime powmod);

my $n = 7037;

while (1) {
    my $p = nth_prime(++$n);
    my $s = $p * $p;
    my $r = (powmod($p - 1, $n, $s) + powmod($p + 1, $n, $s)) % $s;

    if ($r > 10**10) {
        say $n;
        last;
    }
}
