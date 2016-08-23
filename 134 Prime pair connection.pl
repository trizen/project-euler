#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# Date: 23 August 2016
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=134

use strict;
use ntheory qw(forprimes next_prime invmod);

# k = 10^(1+floor(log10(p1)))
# g = (invmod(k, p2) * -p1) % p2
# S = k*g + p1

my $p1  = 5;
my $sum = 0;
my $log = length($p1);
my $pow = 10**$log;

forprimes {
    if (length($p1) != $log) {
        $log += 1;
        $pow *= 10;
    }
    $sum += ((invmod($pow, $_) * -$p1) % $_) * $pow + $p1;
    $p1 = $_;
} 7, next_prime(1000000);

print "$sum\n";
