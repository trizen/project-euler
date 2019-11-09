#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 22 August 2016
# Website: https://github.com/trizen

# https://projecteuler.net/problem=124

# Runtime: 0.244s

use 5.010;
use strict;
use integer;

use ntheory qw(factor_exp is_square_free vecprod);

my @list;
foreach my $i (1 .. 100000) {
    push @list, [
        is_square_free($i)
            ? $i
            : vecprod(map $_->[0], factor_exp($i)),
        $i,
    ];
}

@list = sort {
           ($a->[0] <=> $b->[0])
        || ($a->[1] <=> $b->[1])
} @list;

say $list[10000 - 1][1];
