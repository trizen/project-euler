#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=146

# Runtime: 15.191s

use 5.010;
use strict;
use integer;
use ntheory qw(is_prime next_prime);

my $sum = 0;
for (my $i = 10; $i < 150_000_000; $i += 10) {
    my $x = $i**2;
    if (    is_prime($x + 1)
        and next_prime($x + 1) == $x + 3
        and next_prime($x + 3) == $x + 7
        and next_prime($x + 7) == $x + 9
        and next_prime($x + 9) == $x + 13
        and next_prime($x + 13) == $x + 27) {
        $sum += $i;
    }
}
say $sum;
