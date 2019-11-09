#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 20 August 2017
# Edit: 16 September 2019
# https://github.com/trizen

# https://projecteuler.net/problem=401

# Generalized aglorithm described at:
#   https://trizenx.blogspot.com/2018/11/partial-sums-of-arithmetical-functions.html

# Runtime: ~47 seconds.

use 5.010;
use strict;
use integer;
use warnings;

use experimental qw(signatures);
use ntheory qw(sqrtint mulmod divmod addmod);

my $mod = 10**9;
my $lim = 10**15;

sub f ($n) {
    divmod(mulmod(mulmod($n, $n + 1, $mod), 2 * $n + 1, $mod), 3, $mod) >> 1;
}

sub sum_of_sum_of_squared_divisors ($n) {

    my $s = sqrtint($n);
    my $u = int($n/($s+1));

    my $sum = 0;
    my $prev = f($n);

    foreach my $k (1 .. $s) {
        my $curr = f(int($n/($k+1)));
        $sum  = addmod($sum, mulmod($k, $prev - $curr, $mod), $mod);
        $prev = $curr;
    }

    foreach my $k (1 .. $u) {
        $sum = addmod($sum, mulmod($k*$k, int($n/$k), $mod), $mod);
    }

    return $sum;
}

say sum_of_sum_of_squared_divisors($lim);
