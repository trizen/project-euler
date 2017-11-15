#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 18 September 2017
# https://github.com/trizen

# https://projecteuler.net/problem=320

# Runtime: 28.967s

use 5.010;
use strict;
use warnings;

use List::Util qw(uniq);
use experimental qw(signatures);
use ntheory qw(addmod factor vecsum todigits);

sub factorial_power ($n, $p) {
    ($n - vecsum(todigits($n, $p))) / ($p - 1);
}

sub p_adic_inverse ($p, $k) {

    my $n = $k * ($p - 1);
    while (factorial_power($n, $p) < $k) {
        $n -= $n % $p;
        $n += $p;
    }

    return $n;
}

sub p_320 {

    my $sum = 0;
    my $max = 0;
    my $pow = 1234567890;

    my $from = 10;
    my $to   = 1e6;

    my $mod = 1000000000000000000;

    foreach my $i ($from .. $to) {
        foreach my $p (uniq(factor($i))) {
            my $v = factorial_power($i, $p);
            my $t = p_adic_inverse($p, $pow * $v);
            $max = $t if $t > $max;
        }
        $sum = addmod($sum, $max, $mod);
    }

    return $sum;
}

say p_320();
