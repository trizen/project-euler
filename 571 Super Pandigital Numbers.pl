#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 20 August 2017
# https://github.com/trizen

# https://projecteuler.net/problem=571

# Brute-force solution.

# Runtime: ~20 min

use 5.010;
use strict;
use warnings;

use List::Util qw(uniq all min);
use ntheory qw(todigits fromdigits);
use Algorithm::Combinatorics qw(variations);

my $base  = shift(@ARGV) // 12;    # pandigital in all bases 2..$base
my $first = 10;                    # generate first n numbers

my @digits = (1, 0, 2 .. $base - 1);
my @bases  = reverse(2 .. $base - 1);

my $sum  = 0;
my $iter = variations(\@digits, $base);

while (defined(my $t = $iter->next)) {

    if ($t->[0]) {
        my $d = fromdigits($t, $base);

        if (all { uniq(todigits($d, $_)) == $_ } @bases) {
            say "Found: $d";
            $sum += $d;
            last if --$first == 0;
        }
    }
}

say "Sum: $sum";
