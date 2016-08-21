#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 21 August 2016
# Website: https://github.com/trizen

# https://projecteuler.net/problem=357

use 5.010;
use strict;
use integer;

use List::Util qw(all);
use ntheory qw(divisors is_prime is_square_free);

my $sum = 1;

for (my $n = 2 ; $n <= 100_000_000 ; $n += 2) {
    if (is_square_free($n) and all { is_prime($_ + $n / $_) } divisors($n)) {
        $sum += $n;
    }
}

say $sum;
