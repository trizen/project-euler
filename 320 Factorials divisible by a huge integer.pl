#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 18 September 2017
# https://github.com/trizen

# https://projecteuler.net/problem=320

# Runtime: 1 min, 04 sec

use 5.010;
use strict;
use warnings;

use List::Util qw(uniq);
use ntheory qw(addmod factor);

sub p_adic_valuation {
    my ($n, $p) = @_;

    my $s = 0;
    while ($n >= $p) {
        $s += int($n /= $p);
    }

    return $s;
}

sub p_adic_inverse {
    my ($p, $k) = @_;

    my $n = $k * ($p - 1);
    while (p_adic_valuation($n, $p) < $k) {
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
            my $v = p_adic_valuation($i, $p);
            my $t = p_adic_inverse($p, $pow * $v);
            $max = $t if $t > $max;
        }
        $sum = addmod($sum, $max, $mod);
    }

    return $sum;
}

say p_320();
