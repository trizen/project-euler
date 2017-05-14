#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 13 May 2017
# https://github.com/trizen

# https://projecteuler.net/problem=132

# Runtime: 5 min, 14 sec

use 5.010;
use strict;
use warnings;

use ntheory qw(prime_iterator powmod gcd);

my $n     = 1e9;
my $count = 40;
my $iter  = prime_iterator();

my $factors_sum = 0;

OUTER: while (my $p = $iter->()) {

    gcd($n, $p) == 1 or next;

    my $sum    = 0;
    my $period = 0;

    foreach my $k (0 .. $p) {
        $sum += powmod(10, $k, $p);
        $sum %= $p;
        $period += 1;

        if ($sum == 0) {
            ($n % $period == 0) ? last : next OUTER;
        }
    }

    if ($sum == 0) {
        $factors_sum += $p;
        say "[$count] $p is a prime factor -> $factors_sum";
        last if --$count <= 0;
    }
}

say $factors_sum;
