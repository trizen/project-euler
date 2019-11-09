#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 20 May 2017
# https://github.com/trizen

# Runtime: 33 min, 6 sec

# 18407904

use 5.010;
use strict;
use warnings;

use ntheory qw(:all);

sub rad {
    my ($n) = @_;
    vecprod(map { $_->[0] } factor_exp($n));
}

my $sum   = 0;
my $limit = 120_000 - 1;

for my $a (1 .. $limit >> 1) {
    for my $b ($a + 1 .. $limit - $a) {
        my $c = $a + $b;
        if (    !is_square_free($b)
            and !is_square_free($c)
            and gcd($a, $b, $c) == 1
            and rad($a * $b * $c) < $c
        ) {
            say "$a $b $c = ", $a * $b * $c, " -> ", rad($a * $b * $c);
            $sum += $c;
        }
    }
}

say $sum;
