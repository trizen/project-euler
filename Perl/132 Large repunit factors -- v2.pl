#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 21 September 2019
# https://github.com/trizen

# https://projecteuler.net/problem=132

# Runtime: 0.051s

# See also:
#   https://oeis.org/A178070

use 5.010;
use strict;
use warnings;

use ntheory qw(:all);

my $n     = 1e9;
my $count = 40;

my $factors_sum = 0;

for (my $p = 7 ; ; $p = next_prime($p)) {

    my $z = znorder(10, $p);

    if ($n % $z == 0) {
        $factors_sum += $p;
        last if --$count == 0;
    }
}

say $factors_sum;
