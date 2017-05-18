#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 18 May 2017
# https://github.com/trizen

# https://projecteuler.net/problem=119

# Runtime: 0.258s

use 5.010;
use strict;
use warnings;

use List::Util qw(sum);
use Math::AnyNum qw(ipow);

my $nth = 30;

my @terms;
my $prev = 0;

for (my $n = 1 ; ; ++$n) {

    foreach my $k (1 .. $n) {
        if ($k * log($n) >= log(10) and sum(split(//, ipow($n, $k))) == $n) {
            push @terms, ipow($n, $k);
            say "$n -> $n^$k -> ", ipow($n, $k);
        }
    }

    @terms = sort { $a <=> $b } @terms;

    if (@terms >= 2 * $nth) {
        $terms[$nth - 1] == $prev and last;
        $prev = $terms[$nth - 1];
    }
}

say $terms[$nth - 1];
