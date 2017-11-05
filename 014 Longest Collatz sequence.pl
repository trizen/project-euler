#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# https://github.com/trizen

# The following iterative sequence is defined for the set of positive integers:

# n → n/2 (n is even)
# n → 3n + 1 (n is odd)

# Which starting number, under one million, produces the longest chain?

# https://projecteuler.net/problem=14

# Runtime: 2.222s

use 5.010;
use strict;

my %cache;

sub collatz {
    my ($n) = @_;

    return 1 if ($n == 1);

    $cache{$n} //= (
                    ($n % 2 == 0)
                    ? 1 + collatz($n >> 1)
                    : 1 + collatz((3 * $n + 1) >> 1)
                   );
}

my $num = 0;
my $max = 0;

foreach my $i (1 .. 1e6 - 1) {
    my $value = collatz($i);
    if ($value > $max) {
        $max = $value;
        $num = $i;
    }
}

say $num;
