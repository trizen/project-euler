#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 21 August 2016
# Edit: 07 April 2019
# https://github.com/trizen

# https://projecteuler.net/problem=357

# Runtime: 9.549s

use 5.014;
use strict;
use integer;

use ntheory qw(:all);

my $sum = 0;

forprimes {
    my $n = $_-1;
    if (is_square_free($n) and vecall { is_prime($_ + $n/$_) } divisors($n)) {
        $sum += $n;
    }
} 100_000_000;

say $sum;
