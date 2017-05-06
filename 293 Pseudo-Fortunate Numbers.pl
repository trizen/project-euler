#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 06 May 2017
# https://github.com/trizen

# https://projecteuler.net/problem=293

# Runtime: 0.047s

use 5.010;
use strict;

use ntheory qw(:all);
use List::Util qw(uniq);

my $limit = 1e9;
my @admis;

sub rec {
    my ($n, $p) = @_;

    if ($n > 1 and $n < $limit) {
        push @admis, $n;
    }

    if ($n * $p < $limit) {
        rec($n * $p, $p);
        rec($n * $p, next_prime($p));
    }
}

rec(1, 2);

say vecsum(uniq(map { next_prime($_+1) - $_ } @admis));
