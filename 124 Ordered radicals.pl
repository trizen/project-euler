#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 22 August 2016
# Website: https://github.com/trizen

# https://projecteuler.net/problem=124

use 5.010;
use strict;
use integer;

use ntheory qw(factor is_square_free);
use List::Util qw(uniq product);

my @list;
foreach my $i (1 .. 100000) {
    push @list, [is_square_free($i) ? $i : product(uniq(factor($i))), $i];
}

@list = sort {
           ($a->[0] <=> $b->[0])
        || ($a->[1] <=> $b->[1])
} @list;

say $list[10000-1][1];
