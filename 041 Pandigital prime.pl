#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 27 January 2017
# https://github.com/trizen

# https://projecteuler.net/problem=41

# Runtime: 0.030s

use 5.010;
use strict;
use warnings;

use ntheory qw(forperm is_prime);

# It cannot be a 9-digit pandigital prime as it would be divisible by 3. (45 / 3 = 15)
# It cannot be a 8-digit pandigital prime as it would be divisible by 3. (36 / 3 = 12)

foreach my $n (reverse(1 .. 7)) {
    my $prime = 0;

    forperm {
        my $k = join('', map { $_ + 1 } @_);
        if (is_prime($k)) {
            $prime = $k;
        }
    } $n;

    if ($prime != 0) {
        say "$n-digit pandigital prime: $prime";
        last;
    }
}
