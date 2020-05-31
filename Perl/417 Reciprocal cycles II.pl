#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 17 May 2020
# https://github.com/trizen

# Reciprocal cycles II
# https://projecteuler.net/problem=417

# Runtime: 2 minutes

# Simple solution, by removing any divisibility by 2 and 5 from n, then:
#   L(n) = znorder(10, n)

# Optimization: iterate over the odd integers k and ingore multiples of 5.

use 5.014;

use integer;
use ntheory qw(:all);
use experimental qw(signatures);

my $sum   = 0;
my $limit = 100_000_000;

for (my $k = 3 ; $k <= $limit ; $k += 2) {

    ($k % 5) || next;

    my @smooth = ($k);

    foreach my $p (2, 5) {
        foreach my $n (@smooth) {
            if ($n * $p <= $limit) {
                push @smooth, $n * $p;
            }
        }
    }

    $sum += scalar(@smooth) * znorder(10, $k);
}

say $sum;
