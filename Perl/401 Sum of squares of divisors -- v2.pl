#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 16 September 2019
# https://github.com/trizen

# https://projecteuler.net/problem=401

# Generalized aglorithm described at:
#   https://trizenx.blogspot.com/2018/11/partial-sums-of-arithmetical-functions.html

# Runtime: ~39 seconds.

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

sub sum_of_sum_of_squared_divisors ($n) {      # using the "Dirichlet hyperbola method"

    my $s = sqrtint($n);

    my $total = 0;

    for my $k (1 .. $s) {
        $total = addmod($total, f(int($n/$k)), $mod);
        $total = addmod($total, mulmod($k*$k, int($n/$k), $mod), $mod);
    }

    $total -= mulmod($s, f($s), $mod);

    return $total % $mod;
}

say sum_of_sum_of_squared_divisors($lim);
