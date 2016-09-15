#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=58

# Runtime: 0.040s

use 5.010;
use strict;

use ntheory qw(is_prime);

my $i = 1;
my $primes = 0;

while (1) {

    $primes += grep { is_prime($_) }  (
         3 + $i * (4 * $i - 6),
         5 + $i * (4 * $i - 8),
         7 + $i * (4 * $i - 10)
    );

    if ($i > 4 and ($primes / (4 * ($i - 1) + 1) < 0.1)) {
        say 2 * ($i - 1) + 1;
        last;
    }

    ++$i;
}
