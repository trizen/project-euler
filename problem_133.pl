#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 14 May 2017
# https://github.com/trizen

# https://projecteuler.net/problem=132

# Runtime: 2 min, 18 sec

use 5.010;
use strict;
use warnings;

# 453647705

use ntheory qw(prime_iterator powmod gcd primes vecsum);

my %factors;
my $limit = 100_000;
my $iter  = prime_iterator();

OUTER: while ((my $p = $iter->()) < $limit) {

    ($p == 2 or $p == 5) && next;

    my $sum    = 0;
    my $period = 0;

    for (my $k = 0 ; $k <= $p ; ++$k) {
        $sum += powmod(10, $k, $p);
        $sum %= $p;
        $period += 1;

        if ($sum == 0) {
            (powmod(10, $k, $period) == 0) ? last : next OUTER;
        }
    }

    if ($sum == 0) {
        $factors{$p} = 1;
        say "$p is a prime factor (period: $period)";
    }
}

say vecsum(grep { not exists $factors{$_} } @{primes($limit)});
