#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 13 March 2018
# https://github.com/trizen

# https://projecteuler.net/problem=622

# Runtime: 0.183s

use 5.020;
use strict;
use warnings;

use Math::AnyNum qw(:overload);
use experimental qw(signatures);
use ntheory qw(znorder lcm divisors);

sub rshuffle_cycle_len ($n) {
    lcm(2, znorder(2, $n - 1));
}

my $n = 60;
my $sum = 0;

foreach my $d (divisors(2**$n - 1)) {
    if (rshuffle_cycle_len($d + 1) == $n) {
        $sum += $d + 1;
    }
}

say $sum;
