#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 20 February 2017
# License: GPLv3
# https://github.com/trizen

# https://projecteuler.net/problem=348

# Runtime: 37.866s

use 5.010;
use strict;
use integer;

my %count;
my $count = 0;
my $sum   = 0;

OUTER: for (my $i = 1 ; ; ++$i) {
    for my $j (1 .. $i >> 2) {

        my $s = $i**2;
        my $c = $j**3;
        my $p = $s + $c;

        if ($p eq reverse($p)) {
            push @{$count{$p}}, "$i^2 + $j^3";
            if (@{$count{$p}} == 4) {
                $sum += $p;
                say "$p = [", join(", ", @{$count{$p}}), "]";
                last OUTER if ++$count == 5;
            }
        }
    }
}

say "Sum: $sum";
