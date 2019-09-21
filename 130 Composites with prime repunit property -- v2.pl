#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 12 May 2017
# https://github.com/trizen

# https://projecteuler.net/problem=130

# Runtime: 2.814s

use 5.010;
use strict;
use warnings;

use ntheory qw(gcd powmod is_prime);

my $sum   = 0;
my $count = 0;

for (my $n = 2 ; ; ++$n) {

    is_prime($n)     && next;
    gcd($n, 10) != 1 && next;

    my $r = 1;
    my $p = 0;

    foreach my $k (1 .. $n - 1) {

        $r += powmod(10, $k, $n);
        $r %= $n;
        $p += 1;

        last if ($r == 1);
    }

    if ($r == 1 and ($n - 1) % $p == 0) {
        $sum += $n;
        last if ++$count == 25;
    }
}

say $sum;
